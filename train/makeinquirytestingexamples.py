import csv 
import subprocess
import json
import random 
from watson_developer_cloud import NaturalLanguageClassifierV1

affirmation_csv = open("affirmations.csv", "rb")
negation_csv = open("negations.csv", "rb")

# dosage
    # daily
def dosage_daily_questions(drug):
    daily = []
    daily.append("How many %s pills am I taking today?" % drug)
    daily.append("Am I taking 4 %s pills today?" % drug)
    daily.append("what is today's dosage of %s" % drug)
    daily.append("how much %s am I taking per day" % drug)
    daily.append("what is my daily intake of %s?" % drug)
    return daily

def dosage_occurence_questions(drug):
    daily = []
    daily.append("How many %s pills am I taking?" % drug)
    daily.append("How many %s do I need to take right now?" % drug)
    daily.append("how much %s am I taking next?" % drug)
    return daily

# frequency
    # frequency-number
def frequency_number_questions(drug):
    freq_number = []
    freq_number.append("How many times have I taken %s?" % drug)
    freq_number.append("How often do I take %s?" % drug)
    freq_number.append("How many days have I been on %s?" % drug)
    freq_number.append("How many more days do I need to take %s" % drug)
    return freq_number

# side effects
    # what are the side effects of
def side_effects_list_questions(drug):
    sedq = []
    sedq.append("What side effects does %s have" % drug)
    sedq.append("What are the side effects of %s" % drug)
    sedq.append("what are %s's side effects?" % drug)
    sedq.append("does %s have any side effects" % drug)
    return sedq

def side_effects_cause_questions(drug):
    cause = []
    cause.append("Does %s cause nausea?" % drug)
    cause.append("Is sneezing a symptom of %s" % drug)
    cause.append("is my upset stomach and %s related" % drug)
    cause.append("would %s be the reason for my ulcers" % drug)
    return cause

# calendar questions
    # end date
def calendar_end_questions(drug):
    end = []
    end.append("when will i stop taking %s" % drug)
    end.append("what is my end date for %s?" % drug)
    end.append("how long until i finish %s" % drug)
    return end

def calendar_start_questions(drug):
    start = []
    start.append("when did i start taking %s" % drug)
    start.append("what is my start date for %s?" % drug)
    start.append("how long since i started %s" % drug)
    return start

data = subprocess.check_output('curl -X GET --header "Accept: application/json" "https://watsonpow01.rch.stglabs.ibm.com/services/drug-info/api/v1/drugmap/drugnames?caseSensitive=false&source=ATC"', shell = True)
data = json.loads(data)
sample = random.sample(data['data'], 340)

def affirmations(affirmation_csv, outfile):
    reader = csv.reader(affirmation_csv, delimiter = ",")
    for row in reader:
        outfile.writerow(["%s" % row[0], "affirmation"])

def negations(negation_csv, outfile):
    reader = csv.reader(negation_csv, delimiter = ",")
    for row in reader:
        outfile.writerow(["%s" % row[0], "negation"])

def write_questions(questions, outfile, q_class):
    for question in questions:
        outfile.writerow([question, q_class])

with open("training-data.csv", 'wb') as outfile:
        writer = csv.writer(outfile, delimiter = ",")
        affirmations(affirmation_csv, writer)
        negations(negation_csv, writer)
        for item in sample:
            write_questions(dosage_daily_questions(item), writer, "dosage-daily")
            write_questions(dosage_occurence_questions(item), writer, "dosage-weekly")
            write_questions(frequency_number_questions(item), writer, "frequency-number")
            write_questions(side_effects_list_questions(item), writer, "side-effects-list")
            write_questions(side_effects_cause_questions(item), writer, "side-effects-cause")
            write_questions(calendar_end_questions(item), writer, "calendar-end")
            write_questions(calendar_start_questions(item), writer, "calendar-start")

natural_language_classifier = NaturalLanguageClassifierV1(
    username = "2c85123b-21d8-4bde-9f35-6c66301ecbf4",
    password = "ObBtjTUN7PfP")

with open('training-data.csv', 'rb') as training_data:
    classifier = natural_language_classifier.create(
    training_data=training_data,
    name='My Classfier',
    language='en'
)

print(json.dumps(classifier, indent=2))

# {
#   "status": "Training", 
#   "name": "My Classfier", 
#   "language": "en", 
#   "created": "2016-07-29T04:52:37.513Z", 
#   "url": "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/33fffex86-nlc-55", 
#   "status_description": "The classifier instance is in its training phase, not yet ready to accept classify requests", 
#   "classifier_id": "33fffex86-nlc-55"
# }

# curl -X DELETE -u "2c85123b-21d8-4bde-9f35-6c66301ecbf4":"ObBtjTUN7PfP" \
# "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/33fffex86-nlc-55"
