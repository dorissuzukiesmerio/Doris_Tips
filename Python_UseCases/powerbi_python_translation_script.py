### INTRO:

# The code below can be used on PowerQuery from PowerBI, on a dataset that has a column called "Comments", containing comments in different languages.
# The comments will be translated to English and available in a column called "Comments_English_Translation"
# To run this in another environment (Jupyter notebook, Text Editor, etc - you may need to load the data at the beginning and save it at the end)

### GOOGLETRANS

from googletrans import Translator # documentation : https://pypi.org/project/googletrans/
import pandas as pd

translator = Translator()

dataset = dataset.assign(Comments_English_Translation=dataset['Comments'])
# dataset = dataset.rename(columns = {'Comments_Local_Language':'Comments'})

translations = {}

unique_elements = dataset['Comments_English_Translation'].unique()


for element in unique_elements:
# add translation to the dictionary
    translations[element] = translator.translate(element).text

# modify all the terms of the data frame by using the previously created dictionary
dataset['Comments_English_Translation'].replace(translations, inplace = True)

dataset['Comments_English_Translation'] = dataset['Comments_English_Translation'].str.capitalize()
