trainIdx = shuffledIdx(1:numTrainSamples);
testIdx = shuffledIdx(numTrainSamples+1:end);
 
% Separate training and testing data
trainData = data(trainIdx, :);
testData = data(testIdx, :);

X_train = X(trainIdx, :);
y_train = data.Label(trainIdx);
X_test = X(testIdx, :);
y_test = data.Label(testIdx);
% Choose model there

[m, n] = size(X_train);
b = zeros(n, 1); % Initialize coefficients
alpha = 0.03; % Learning rate
num_iterations = 5000; % Number of iterations

for iter = 1:num_iterations
    z = X_train * b; 
    prediction = 1 ./ (1 + exp(-z));
    loss = -mean(y_train .* log(prediction) + (1 - y_train) .* log(1 - prediction));
    gradient = X_train' * (prediction - y_train) / m;
    b = b - alpha * gradient; 
    if alpha - gradient <= 1e-3
        disp('out');
        break
    end

    if mod(iter, 100) == 0
        disp(['Iteration ', num2str(iter), ': Loss = ', num2str(loss)]);
    end
end

% Make predictions on test data
z_test = X_train * b;
predictions_test = 1 ./ (1 + exp(-z_test)); % Sigmoid function
predictions_binary_test = predictions_test >= 0.5; % Convert probabilities to binary outcomes

% Evaluate the model performance
accuracy = mean(predictions_binary_test == y_train);
disp(['Train Accuracy: ', num2str(accuracy)]);

z_test = X_test * b;
predictions_test = 1 ./ (1 + exp(-z_test)); % Sigmoid function
predictions_binary_test = predictions_test >= 0.5; % Convert probabilities to binary outcomes

% Evaluate the model performance
accuracy = mean(predictions_binary_test == y_test);
disp(['Test Accuracy: ', num2str(accuracy)]);