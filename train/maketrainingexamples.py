import os 
import subprocess
import json
import csv 
import numpy
import random 


data = subprocess.check_output('curl -X GET --header "Accept: application/json" "https://watsonpow01.rch.stglabs.ibm.com/services/drug-info/api/v1/drugmap/drugnames?caseSensitive=false&source=ATC"', shell = True)
data = json.loads(data)
affirmation_csv = open("affirmations.csv", "rb")
negation_csv = open("negations.csv", "rb")

def affirmations(affirmation_csv, outfile):
    reader = csv.reader(affirmation_csv, delimiter = ",")
    for row in reader:
        outfile.writerow(["%s" % row[0], "affirmation"])

def negations(negation_csv, outfile):
    reader = csv.reader(negation_csv, delimiter = ",")
    for row in reader:
        outfile.writerow(["%s" % row[0], "negation"])

def write_questions(questions, outfile):
    for question in questions:
        outfile.writerow([question, "INQUIRY"])

def make_dosage_questions(drug):
    dosage = []
    dosage.append("How many %s pills should I take?" % drug)
    dosage.append("How many %s should I take?" % drug)
    dosage.append("What number of %s should I take" % drug)
    dosage.append("What is my daily dosage of %s" % drug)
    dosage.append("What is my weekly dosage of %s" % drug)
    dosage.append("Whats my dosage of %s today" % drug)
    dosage.append("How many of them?")
    dosage.append("Is it okay to take 5 %s pills?" % drug)
    return dosage

def make_frequency_questions(drug):
    frequency = []
    frequency.append("How frequently do I take %s?" % drug)
    frequency.append("How many times do I take %s?" % drug)
    frequency.append("How often do I take %s?" % drug)
    frequency.append("At what rate do I take %s?" % drug)
    frequency.append("Am I taking %s more than 3 times a week?" % drug)
    return frequency

def make_drug_side_effect_questions(drug):
    drug_side_effects = []
    drug_side_effects.append("what is the side effect of %s" % drug)
    drug_side_effects.append("What are the side effects of %s?" % drug)
    drug_side_effects.append("Does %s have any side affects?" % drug)
    drug_side_effects.append("what are %s's side effects?" % drug)
    drug_side_effects.append("Is coughing a side effect of %s" % drug)
    drug_side_effects.append("What is causing my stomach pains?")
    return drug_side_effects

def make_pill_count_questions(drug):
    pill_count = []
    pill_count.append("how many %s do I have left?" % drug)
    pill_count.append("how many %s pills do I have?" % drug)
    pill_count.append("what number of %s are left" % drug)
    return pill_count

def make_calendar_questions(drug):
    calendar = []
    calendar.append("when do I stop taking %s?" % drug)
    calendar.append("when did I start taking %s?" % drug)
    calendar.append("when is the next time I'll take %s?" % drug)
    calendar.append("when was the last time I took %s?" %drug)
    calendar.append("How many more times in July will I take %s?" %drug)
    calendar.append("How many times will I take %s in the fall?" %drug)
    return calendar

with open("training.csv", 'wb') as outfile:
        writer = csv.writer(outfile, delimiter = ",")
        affirmations(affirmation_csv, writer)
        negations(negation_csv, writer)
        sample = random.sample(data['data'], 500)
        for item in sample:
            dosage_questions = make_dosage_questions(item)
            frequency_questions = make_frequency_questions(item)
            drug_side_effects_questions = make_drug_side_effect_questions(item)
            pill_count_questions = make_pill_count_questions(item)
            calendar_questions = make_calendar_questions(item)
            write_questions(dosage_questions, writer)
            write_questions(frequency_questions, writer)
            write_questions(drug_side_effects_questions, writer)
            write_questions(pill_count_questions, writer)
            write_questions(calendar_questions, writer)

