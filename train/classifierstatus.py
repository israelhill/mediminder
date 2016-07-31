from watson_developer_cloud import NaturalLanguageClassifierV1
import json 

classifier_id = '341781x90-nlc-704'
natural_language_classifier = NaturalLanguageClassifierV1(
    username = "2c85123b-21d8-4bde-9f35-6c66301ecbf4",
    password = "ObBtjTUN7PfP")

status = natural_language_classifier.status(classifier_id)
print (json.dumps(status, indent=2))