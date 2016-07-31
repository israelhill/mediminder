require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'
require 'rest-client'
require 'json'
require 'active_record'
require 'fuzzystringmatch'

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

def determine_drug(response, drug_array)
  jarow = FuzzyStringMatch::JaroWinkler.create( :native )
  drug_array.each {|drug|
    response.split(/[\s]/).each { |word|
      score = jarow.getDistance(word, drug)
      if score >= 0.80
        puts drug
        return drug
      end
    }}


end

def determine_side_effects(drug)
  url = 'https://watsonpow01.rch.stglabs.ibm.com/services/drug-info/api/v1/drugdetail/drugs/' + drug.downcase + '?includeFilter=PatientEducation&pediatric=false'
  data = JSON.parse RestClient.get(url)
  side_effects_string = data['patientEducationSheets'][0]['sideEffects']
  side_effects_array = []
  matching_regex =/<li>([^<]*)<\/li>/
  side_effects_string.scan(matching_regex).each { |side_effect|
    side_effect.join(' ').split(';').each { |parsed_side_effect|
      if not parsed_side_effect.blank?
        side_effects_array.push(parsed_side_effect.strip)
      end
    }
  }
  puts(side_effects_array)
end

