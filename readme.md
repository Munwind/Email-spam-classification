# Email Classification Project

This project involves developing a machine learning model to classify emails. The project includes several scripts to preprocess data, split the dataset, compute term frequency-inverse document frequency (TF-IDF) values, train the model using logistic regression, and evaluate its performance.

## Project Structure
The project contains the following files:
1. **tf_idf.m**: Script to compute the TF-IDF values for the email dataset.
2. **testPreprocessing.m**: Script to preprocess the email data, including cleaning and preparing the text for further analysis.
3. **predict_email_label.m**: Script to predict the label of an email using the trained model.
4. **evaluate_metrics.m**: Script to evaluate the performance of the model using various metrics.
5. **evaluate_new_data.m**: Script to evaluate the model on new email data.
6. **logisticRegression.m**: Script to train a logistic regression model on the email dataset.
7. **main.m**: Main script to run the entire email classification pipeline.
8. **stopWord.txt**: A text file containing stop words to be removed during preprocessing.
9. **vectorize_new_emails.m**: Script to vectorize new email data for prediction.
10. **email.csv**: The dataset containing emails and their labels.


## Requirements
- MATLAB or Octave

## Installation
1. Clone the repository to your local machine.
2. Ensure MATLAB or Octave is installed on your system.

## Usage
### Run main model

Run _main.m_ to execute the entire email classification pipeline.

```
main
```
### Run demo

Run _evaluate_new_data.m_ to evaluate the model on new email data.

```
evaluate_new_data
```

### Configuration

1. **Data Preprocessing:**
Run _testPreprocessing.m_ to preprocess the email data. This script will clean the text and prepare it for feature extraction.

```
testPreprocessing
```
2. **Splitting the Dataset:**

Run _split_data.m_ to split the preprocessed data into training and testing sets.

```
split_data
```

3. **Computing TF-IDF:**
Run _tf_idf.m_ to compute the TF-IDF values for the email data.

```
tf_idf
```

4. **Training the Model:**
Run _logisticRegression.m_ to train a logistic regression model on the email dataset.

```
logisticRegression
```

5. **Predicting Email Labels:**
Run _predict_email_label.m_ to predict the labels of emails using the trained model.

```
predict_email_label
```

6. **Evaluating the Model:**
Run _evaluate_metrics.m_ to evaluate the performance of the model using various metrics.

```
evaluate_metrics
```

7. **Vectorizing New Emails:**
Run _vectorize_new_emails.m_ to vectorize new email data for prediction.

```
vectorize_new_emails
```

## Data
- **stopWord.txt**: Contains stop words that are removed during the preprocessing stage.
- **email.csv**: Contains the email dataset with emails and their corresponding labels.
