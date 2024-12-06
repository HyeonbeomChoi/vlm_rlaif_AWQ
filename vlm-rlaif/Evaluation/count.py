import json
import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-p", "--json_path", required=True, help="The path to file containing prediction.")
parser.add_argument("-t", "--score_threshold", required=True, type=int, help="The threshold for the score.")

args = parser.parse_args()

with open(args.json_path, 'r') as f:
    data = json.load(f)

print(f"Length of prediction data: {len(data)}")
scores = [int(value[0]['score']) for key, value in data.items()]

# Calculate average score
average_score = sum(scores) / len(scores)

# Calculate accuracy (yes if the score is above the threshold)
yes_count = len([1 for score in scores if score >= args.score_threshold])
no_count = len(scores) - yes_count
accuracy = yes_count / len(scores)

# Count each score (1, 2, 3, 4, 5)

count_1 = len([1 for score in scores if score == 1])
count_2 = len([1 for score in scores if score == 2])
count_3 = len([1 for score in scores if score == 3])
count_4 = len([1 for score in scores if score == 4])
count_5 = len([1 for score in scores if score == 5])

print(f"Count of score 1: {count_1}")
print(f"Count of score 2: {count_2}")
print(f"Count of score 3: {count_3}")
print(f"Count of score 4: {count_4}")
print(f"Count of score 5: {count_5}")

print(f"Average score: {average_score}")
print(f"Yes count: {yes_count}")
print(f"No count: {no_count}")
print(f"Accuracy: {accuracy}")
