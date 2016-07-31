require 'twilio-ruby'

class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!, :only => "reply"

  def reply
    message_body = params['Body']
    from_number = params['From']
    boot_twilio
    sms = @client.account.messages.create(
        from: '+17347864530',
        to: from_number,
        body: "Hello there, thanks for texting me. Your number is #{from_number}."
    )

  end

  private
  def boot_twilio
    account_sid = 'ACee177252e5f1e4a5c4c19b8e1e10d5d9'
    auth_token = '92760c86abd82c59035d16709b99ee8c'
    @client = Twilio::REST::Client.new account_sid, auth_token
  end
end