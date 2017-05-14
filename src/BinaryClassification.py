# Source : https://www.hackerearth.com/practice/machine-learning/data-manipulation-visualisation-r-python/tutorial-data-manipulation-numpy-pandas-python/tutorial/?utm_campaign=&utm_medium=email&utm_source=miscellaneous
# predict if the salary of a given person is less than or more than 50K.
import pandas as pd
from sklearn import preprocessing
# load training data
train  = pd.read_csv("../../data/train.csv")
# load test data
test = pd.read_csv("../../data/test.csv")
#check data set
train.info()
print ("The train data has",train.shape)
print ("The test data has",test.shape)
train.head()

# Checking for missing values
nans = train.shape[0] - train.dropna().shape[0]
print ("%d rows have missing values in the train data" %nans)

nand = test.shape[0] - test.dropna().shape[0]
print ("%d rows have missing values in the test data" %nand)

# which columns have missing values
print train.isnull().sum()

# Let's count the number of unique values from character variables
cat = train.select_dtypes(include=['O'])
cat.apply(pd.Series.nunique)


#Education
train.workclass.value_counts(sort=True)
train.workclass.fillna('Private',inplace=True)

#Occupation
train.occupation.value_counts(sort=True)
train.occupation.fillna('Prof-specialty',inplace=True)

#Native Country
train['native.country'].value_counts(sort=True)
train['native.country'].fillna('United-States',inplace=True)	

print train.isnull().sum()

#check proportion of target variable
train.target.value_counts()/train.shape[0]


crosstab = pd.crosstab(train.education, train.target,margins=True)/train.shape[0]
print crosstab

#load sklearn and encode all object type variables
from sklearn import preprocessing

for x in train.columns:
    if train[x].dtype == 'object':
        lbl = preprocessing.LabelEncoder()
        lbl.fit(list(train[x].values))
        train[x] = lbl.transform(list(train[x].values))
print train.head()
