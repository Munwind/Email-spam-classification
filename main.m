% Load the dataset
clear; clc;
data = readtable ('email.csv');

% Preprocess the message text
data.Message = lower(data.Message);
data.Message = regexprep(data.Message, '[^\w\s]', '');
data.TokenizedMessage = cellfun(@(x) strsplit(x), data.Message, 'UniformOutput', false);

% Get the label
data.Label = categorical(data.Category); % Convert labels to categorical
data.Label = double(data.Label == 'spam'); % Encode 'spam' as 1 and 'ham' as 0

% Split the data into training and testing
split_data;

disp(trainData(1:5, :));
