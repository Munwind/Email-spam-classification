% Load the dataset
clear; clc;
data = readtable ('email.csv');

% Preprocess the message text
data.Message = lower(data.Message);%
data.Message = regexprep(data.Message, '[^\w\s]', '');
data.TokenizedMessage = cellfun(@(x) strsplit(x), data.Message, 'UniformOutput', false);

% Delete stop words and stemming





% Feature extraction there  use TF - IDF
[tfidfMatrix, dict] = tf_idf(data(1:5, :));

% Compute the L2 norms for each row
rowNormsL2 = sqrt(sum(tfidfMatrix.^2, 2));

% Normalize each row by its L2 norm
tf_idf_data = tfidfMatrix ./ rowNormsL2;

% Get the label
data.Label = categorical(data.Category); % Convert labels to categorical
data.Label = double(data.Label == 'spam'); % Encode 'spam' as 1 and 'ham' as 0

% Split the data into training and testing
%split_data;

% Choose model there





