require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'

# put your own credentials here
account_sid = 'ACee177252e5f1e4a5c4c19b8e1e10d5d9'
auth_token = '92760c86abd82c59035d16709b99ee8c'
FROM_NUMBER = '+17347864530'
TO_NUMBER = '+17343550556'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

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

def send_negation_response_message(phone, caregiverFirstName, caregiverLastName)
  @client.account.messages.create({ :from => FROM_NUMBER,
                                    :to => phone,
                                    :body => 'Your caregiver %s %s has been notified that you haven\'t taken your medicine yet. They should get back to you as soon as they can.' %[caregiverFirstName, caregiverLastName]
                                  })

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

def send_side_effect_cause_message(drug, sideeffect, flag)
  if (flag)
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'yes it looks like %s can cause %s. If you are experiencing %s ask your caregiver to let your doctor know right away' % [drug, sideeffect]
                                    })
  else
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'no %s does not seem to cause %s. Talk to your caregiver about visiting the doctor for more help' % [drug, sideeffect]
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

def send_response_to_received_message(name, drug, response, phone, caregiverFirstName, caregiverLastName)
  responseType = determine_response_type(response)
  side_effects = determine_side_effects(drug)
  dosage = determine_dosage(drug, name)
  case responseType
    when 'affirmation'
      send_confirmation(name, phone)
    when 'negation'
      send_negation_response_message(phone, caregiverFirstName, caregiverLastName)
    when 'dosage-occurence'
      send_dosage_occurence_message(drug, dosage, phone)
    when 'dosage-daily'
      send_dosage_daily_message(drug, dosage, phone, frequency)
    when 'frequency-number'
      send_frequency_message(dosage, drug,phone, frequency)
    when 'side-effects-list'
      send_side_effect_list_message(drug, side_effects)
    when 'side-effects-cause'
      possible_side_effect = determine_user_side_effect(response)
      flag = is_side_effect_of_drug(drug, possible_side_effect)
      send_side_effect_cause_message(drug, possible_side_effect, flag)
    when 'calendar-start'
      start_date = determine_calendar_start_date(name, drug)
      send_calendar_start_date(phone, drug, start_date)
    when 'calendar-end'
      end_date = determine_calednar_end_date(name, drug)
      send_calendar_end_date(phone, drug, end_date)
    else
      send_unknown_message_response(name, phone)
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

