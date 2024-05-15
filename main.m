% Load the dataset
clear; clc;
data = readtable ('email.csv');
data = table2cell(data);
%tf_idf(data(1:10,:));
%disp(data);

% Preprocess the message text
%data.Message = lower(data.Message);%
%data.Message = regexprep(data.Message, '[^\w\s]', '');
%data.TokenizedMessage = cellfun(@(x) strsplit(x), data.Message, 'UniformOutput', false);

% Delete stop words and stemming






% Feature extraction there  use TF - IDF






% Get the label
%data.Label = categorical(data.Category); % Convert labels to categorical
%data.Label = double(data.Label == 'spam'); % Encode 'spam' as 1 and 'ham' as 0

% Split the data into training and testing
%split_data;

%disp(trainData(1:5, :));

% Choose model there





