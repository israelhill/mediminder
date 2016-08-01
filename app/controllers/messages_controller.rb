require 'twilio-ruby'
require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'rest-client'
require 'json'
require 'active_record'
require 'fuzzystringmatch'

class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!, :only => "reply"
  FROM_NUMBER = '+16503833589'

  def reply
    message_body = params['Body']
    puts 'Message Body: ' + message_body
    @child_number = params['From']

    @messenger = Child.find_by_phone @child_number[2..-1]
    puts 'Child Phone number: ' + @child_number[2..-1]

    @parent = @messenger.read_attribute('user_id')
    @child_phone = @child_number
    @dosage_list = ChildDrug.find_all_by_child_id @messenger.read_attribute('child_id')

    boot_twilio
    sms = send_response_to_received_message(message_body, Array.new)

  end

  private
  def boot_twilio
    account_sid = 'ACa781815d12f352a8c5d748c1c816c16b'
    auth_token = 'a65631733202260ddeb4874331c94bcc'
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def send_reminder_initial(name, drug, time, dosage, phone)
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'Hey %s! This is a MediMinder reminder that you need to take your %s medication. Please take your usual %d pills of %s in the next few minutes and send us a response when you do. Have a great day!' % [name, dosage, time, drug]})
  end

  def send_confirmation(name, phone)
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'Great job %s! We will let you know when your next dosage is. Have a great day!' % name})
  end

  def send_no_response_message(name, phone, drug)
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'Hey %s, we haven\'t heard if you\'ve taken your %s yet. Please send a response to this number as soon as you can if you have taken it.' %[name, drug]
                                    })
  end

  def send_negation_response_message(phone, relationship)
    case relationship
      when 'Mother'
        @client.account.messages.create({ :from => FROM_NUMBER,
                                          :to => phone,
                                          :body => 'Your mom has been notified that you haven\'t taken your medicine yet. She should get back to you as soon as they can.'
                                        })
      when 'Father'
        @client.account.messages.create({ :from => FROM_NUMBER,
                                          :to => phone,
                                          :body => 'Your dad has been notified that you haven\'t taken your medicine yet. He should get back to you as soon as they can.'
                                        })
    end
  end

  def send_dosage_occurence_message(drug, dosage, phone)
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'You usually take %d %s pills at a time. Ask before you take any other amount!' %[dosage, drug]
                                    })
  end
  def send_dosage_daily_message(drug, dosage, phone, frequency)
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'You usually take %d %s pills %d times a day' %[dosage, drug, frequency]
                                    })
  end

  def send_frequency_message(dosage, drug, phone, frequency)
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'You usually take %d pills of your %s medicine %d times a day' %[dosage, drug, frequency]
                                    })
  end

  def send_side_effect_list_message(drug, sideeffects)
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'The typical side effects of %s are %s. If you are experiencing any of these symptoms, tell your caregiver right away' %[drug, sideeffects]
                                    })
  end

  def send_side_effect_cause_message(drug, flag, relationship)
    if (flag)
      @client.account.messages.create({ :from => FROM_NUMBER,
                                        :to => phone,
                                        :body => 'yes it looks like %s can cause that to happen. If you are experiencing %s ask your %s to let your doctor know right away' % [drug, relationship]
                                      })
    else
      @client.account.messages.create({ :from => FROM_NUMBER,
                                        :to => phone,
                                        :body => 'no %s does not seem to cause that. Talk to your %s about visiting the doctor for more help' % [drug, relationship]
                                      })

    end
  end

  def send_auto_reminder_message(name, drug, phone)
    dosage = determine_dosage(drug, name)
    send_reminder_initial(name, drug, time, dosage, phone)
  end

  def send_automatic_message(name, drug, time, phone)
    dosage = determine_dosage(drug, name)
    send_reminder_initial(name, drug, time, dosage, phone)
  end

  def send_response_to_received_message(response, drug_array)
    child_name = @messenger.read_attribute('first_name')
    # parent_name = @parent.read_attribute('first_name')
    child_phone_number = @child_phone
    drug = determine_drug(response, drug_array)

    if drug != 'drug not found'
      dosage_row = ChildDrug.where('child_drugs.drug_name = %s AND child_drugs.child_id = %s' % [drug, @messenger.read_attribute('id')])
      @dosage = dosage_row.read_attribute('dosage')

      frequency_row = ChildDrug.where('child_drugs.drug_name = %s AND child_drugs.child_id = %s' % [drug, @messenger.read_attribute('id')])
      @frequency = frequency_row.read_attribute('frequency')
    end

    response_type = determine_response_type(response)
    puts 'Response type: ' + response_type
    side_effects = determine_side_effects(drug)
    dosage = @dosage
    frequency = @frequency
    relationship = @messenger.read_attribute('relation_type')

    case response_type
      when 'affirmation'
        send_confirmation(child_name, child_phone_number)
      when 'negation'
        send_negation_response_message(child_phone_number, relationship)
      when 'dosage-occurence'
        send_dosage_occurence_message(drug, dosage, child_phone_number)
      when 'dosage-daily'
        send_dosage_daily_message(drug, dosage, child_phone_number, frequency)
      when 'frequency-number'
        send_frequency_message(dosage, drug, child_phone_number, frequency)
      when 'side-effects-list'
        send_side_effect_list_message(drug, side_effects)
      when 'side-effects-cause'
        flag = is_side_effect_of_drug(drug, response)
        send_side_effect_cause_message(drug, flag, relationship)
      when 'calendar-start'
        start_date = get_calendar_start_date(child_name, drug)
        send_calendar_start_date(phone, drug, start_date)
      when 'calendar-end'
        end_date = get_calendar_end_date(child_name, drug)
        send_calendar_end_date(phone, drug, end_date)
      else
        send_unknown_message_response(child_name, child_phone_number)
    end


  end

  def send_calendar_start_date(phone, drug, start_date)
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'You started taking %s on %s' % [drug, start_date]
                                    })
  end

  def send_calendar_end_date(phone, drug, end_date)
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'You will finish taking %s on %s' % [drug, end_date]
                                    })
  end

  def send_unknown_message_response(name, phone)
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'Sorry %s, I didn\'t understand what you were trying to ask. Can you try asking in a different way?' % [name]
                                    })
  end

  def get_drug_array
    data = RestClient.get('https://watsonpow01.rch.stglabs.ibm.com/services/drug-info/api/v1/drugdetail/drugnames?userxcui=false')
    parsed_data = JSON.parse data
    drugs_array = []
    parsed_data['data'].each { |drug|
      drug.split(/[,,;]/).each { |parsed_drug|
        if not parsed_drug.blank?
          drugs_array.push(parsed_drug.strip)
        end
      }
    }
    return drugs_array
  end
end