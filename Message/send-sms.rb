require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'

# put your own credentials here
account_sid = 'ACee177252e5f1e4a5c4c19b8e1e10d5d9'
auth_token = '
92760c86abd82c59035d16709b99ee8c'
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


