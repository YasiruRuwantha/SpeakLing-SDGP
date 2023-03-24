import pysrt
import re

subs = pysrt.open('C:/Users/Yasiru/Downloads/datasets/030926.srt')
text = ''
for sub in subs:
    text += sub.text_without_tags + '\n'

text = re.sub(r'[^\w\s\n]+', '', text)  # remove special characters
words = set(text.lower().split())  # create set of unique words

with open('example.txt', 'w') as f:
    f.write('\n'.join(words))