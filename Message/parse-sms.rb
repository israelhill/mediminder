require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'
require 'rest-client'
require 'json'

# put your own credentials here
account_sid = 'ACee177252e5f1e4a5c4c19b8e1e10d5d9'
auth_token = '92760c86abd82c59035d16709b99ee8c'
FROM_NUMBER = '+17347864530'
TO_NUMBER = '+17343550556'

CLASSIFIER_ID = '341781x90-nlc-704'
CLASSIFIER_USER_ID = '2c85123b-21d8-4bde-9f35-6c66301ecbf4'
CLASSIFIER_PASSWORD = 'ObBtjTUN7PfP'


def determine_response_type(response)
  url = 'https://' + CLASSIFIER_USER_ID + ':' + CLASSIFIER_PASSWORD +  '@gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/' + CLASSIFIER_ID + '/classify'
  data = JSON.parse RestClient.get(url, :params => {:text => response})
  classification = data['top_class']
  return classification
end
