require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'
require 'rest-client'
require 'json'
require 'active_record'
require 'fuzzystringmatch'

# put your own credentials here
# account_sid = 'ACee177252e5f1e4a5c4c19b8e1e10d5d9'
# auth_token = '92760c86abd82c59035d16709b99ee8c'
# FROM_NUMBER = '+17347864530'
# TO_NUMBER = '+17343550556'

# @json_data = '{
#       "Acetylcysteine": ["allergic reactions like skin rash, itching or hives, swelling of the face, lips, or tongue", "breathing problems", "chest tightness, pain", "clamminess", "coughing up blood", "fever", "changes in taste", "drowsiness", "mouth sores", "nausea, vomiting", "runny nose"],
#       "Gentamicin": ["burning, stinging or irritation", "difficulty hearing or ringing in the ears", "dizziness", "increased thirst", "loss of balance", "muscle weakness", "nausea", "pain or difficulty passing urine", "blurred vision (usually temporary)"],
#       "Ciprofloxacin": ["allergic reactions like skin rash, itching or hives, swelling of the face, lips, or tongue", "blurred vision that does not go away", "temporary blurred vision", "tearing or feeling of something in the eye"]
#   }'
#
# @drug_array = Array.new
#
# @drug_data = JSON(@json_data)
# puts @drug_data
# @drug_data.each do |key, value|
#   @drug_array.push key
# end


@drug_acet = ["allergic reactions like skin rash, itching or hives, swelling of the face, lips, or tongue", "breathing problems", "chest tightness, pain", "clamminess", "coughing up blood", "fever", "changes in taste", "drowsiness", "mouth sores", "nausea, vomiting", "runny nose"]
@drug_gent = ["burning, stinging or irritation", "difficulty hearing or ringing in the ears", "dizziness", "increased thirst", "loss of balance", "muscle weakness", "nausea", "pain or difficulty passing urine", "blurred vision (usually temporary)"]
@drug_cip = ["allergic reactions like skin rash, itching or hives, swelling of the face, lips, or tongue", "blurred vision that does not go away", "temporary blurred vision", "tearing or feeling of something in the eye"]


@drug_data = Hash["Acetylcysteine", @drug_acet, "Gentamicin", @drug_gent, "Ciprofloxacin", @drug_cip]
puts @drug_data



