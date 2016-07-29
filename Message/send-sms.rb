require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'

# put your own credentials here
account_sid = 'ACee177252e5f1e4a5c4c19b8e1e10d5d9'
auth_token = '
92760c86abd82c59035d16709b99ee8c'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

@client.account.messages.create({
                                    :from => '+17347864530',
                                    :to => '+17343550556',
                                    :body => 'Hey Wenlu. It is time to take your pills now',
                                })