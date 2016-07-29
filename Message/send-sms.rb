require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'

# put your own credentials here
account_sid = 'ACee177252e5f1e4a5c4c19b8e1e10d5d9'
auth_token = '92760c86abd82c59035d16709b99ee8c'
FROM_NUMBER = '+17347864530'
TO_NUMBER = '+17343550556'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

def send_reminder_initial(name, drug, dosage, phone)
  @client.account.messages.create({ :from => FROM_NUMBER,
                                    :to => phone,
                                    :body => 'Hey %s! This is a MediMinder reminder that you need to take your medication. Please take your usual %d pills of %s in the next few minutes and send us a response when you do. Have a great day!' % [name, dosage, drug]})
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

def send_negation_response_message(name, phone, caregiverFirstName, caregiverLastName)
  @client.account.messages.create({ :from => FROM_NUMBER,
                                    :to => phone,
                                    :body => 'Your caregiver %s %s has been notified that you haven\'t taken your medicine yet. They should get back to you as soon as they can.' %[caregiverFirstName, caregiverLastName]
                                  })

end

def send_dosage_message(drug, dosage, phone, frequency)
  @client.account.messages.create({ :from => FROM_NUMBER,
                                    :to => phone,
                                    :body => 'You usually take %d %s pills %d a day' %[dosage, drug, frequency]
                                  })
end

def send_frequency_message(drug, phone, frequency)
  @client.account.messages.create({ :from => FROM_NUMBER,
                                    :to => phone,
                                    :body => 'You usually take your %s medicine %d a day' %[drug, frequency]
                                  })
end

def send_side_effect_list_message(drug, sideeffects)
  @client.account.messages.create({ :from => FROM_NUMBER,
                                    :to => phone,
                                    :body => 'The typical side effects of %s are $s. If you are experiencing any of these symptoms, tell your caregiver right away' %[drug, sideeffects]
                                  })
end

def send_side_effect_cause_message(drug, sideeffect, flag)
  if (flag)
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'yes it looks like %s can $s. If you are experiencing %s ask your caregiver to let your doctor know right away' % [drug, sideeffect]
                                    })
  else
    @client.account.messages.create({ :from => FROM_NUMBER,
                                      :to => phone,
                                      :body => 'no %s does not seem to cause %s. Talk to your caregiver about visiting the doctor for more help' % [drug, sideeffect]
                                    })

  end
end

