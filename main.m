
%To run this program, first we run mainTest, then run main :D

% Encoding category ham = 0, spam = 1

encodedCategories = double(strcmp(finalOutput(:, 1), 'spam'));

% Feature extraction there  use TF - IDF
[tfidfMatrix, dict] = tf_idf(finalOutput);

% Compute the L2 norms for each row
rowNormsL2 = sqrt(sum(tfidfMatrix.^2, 2));

% Normalize each row by its L2 norm
tf_idf_data = tfidfMatrix ./ rowNormsL2;


numDocuments = size(tf_idf_data , 1);
tf_idf_data = [ones(numDocuments, 1) tf_idf_data];

d = size(tf_idf_data, 2);
weight_init = zeros(1, d);

%divide data to train and test set
rng(42);
train_ratio = 0.8;
num_train = round(train_ratio * numDocuments);
indices = randperm(numDocuments);
train_indices = indices(1: num_train);
test_indices = indices(num_train + 1: end);

%separate train and set data
train_input = tf_idf_data(train_indices, :);
train_label = encodedCategories(train_indices);
test_input = tf_idf_data(test_indices, :);
test_label = encodedCategories(test_indices);

%print the number of samples for each label in the original dataset
fprintf('Original Dataset:\n');
fprintf('Label 0: %d\n', sum(encodedCategories == 0));
fprintf('Label 1: %d\n', sum(encodedCategories == 1));

%print the number of samples for each label in the training set
fprintf('Training Set:\n');
fprintf('Label 0: %d\n', sum(train_label == 0));
fprintf('Label 1: %d\n', sum(train_label == 1));

%print the number of samples for each label in testing set
fprintf('Testing Set: \n');
fprintf('Label 0: %d\n', sum(test_label == 0));
fprintf('Label 1: %d\n', sum(test_label == 1));

%Statistic for logistic regression model 
tol = 1e-6;
eta = 0.5;
max_iter = 30000;


%Training Process perform here
[loss, weight] = logisticRegression(train_input, train_label, tol, eta, weight_init, max_iter);

%plot for training loss
figure;
plot(loss);
xlabel('Iterations');
ylabel('Loss');
title('Loss over Iterations');

%calculating the prediction value of model
predicted_function = @(z) 1 ./ (1 + exp(-z));
train_prediction = predicted_function(weight * train_input');
test_prediction = predicted_function(weight * test_input');

%labeled for prediction value
threshold = 0.5;
train_predicted_label = train_prediction >= threshold;
train_predicted_label = train_predicted_label';
test_predicted_label = test_prediction >= threshold;
test_predicted_label = test_predicted_label';

% Evaluate the efficience of model by accuracy, f1 score, precision and
% recall

%Evaluation for training test
[train_precision, train_recall, train_f1_score] = evaluate_metrics(train_predicted_label, train_label);
accuracy_at_train = sum(train_predicted_label == train_label) / num_train;
fprintf('Training Set metric: \n');
fprintf('Precision: %f\n', train_precision);
fprintf('Recall: %f\n', train_recall);
fprintf('F1 score: %f\n', train_f1_score);
fprintf('Accuracy: %f\n', accuracy_at_train);

%Evaluation for testing test
[test_precision, test_recall, test_f1_score] = evaluate_metrics(test_predicted_label, test_label);
accuracy_at_test = sum(test_predicted_label == test_label) / (numDocuments - num_train);
fprintf('Testing Set metric: \n');
fprintf('Precision: %f\n', test_precision);
fprintf('Recall: %f\n', test_recall);
fprintf('F1 score: %f\n', test_f1_score);
fprintf('Accuracy: %f\n', accuracy_at_test);




