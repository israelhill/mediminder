import json
from watson_developer_cloud import NaturalLanguageClassifierV1 as NaturalLanguageClassifier

natural_language_classifier = NaturalLanguageClassifier(
    username = "2c85123b-21d8-4bde-9f35-6c66301ecbf4",
    password = "ObBtjTUN7PfP")

status = natural_language_classifier.status('33fffex86-nlc-55')
print (json.dumps(status, indent=2))