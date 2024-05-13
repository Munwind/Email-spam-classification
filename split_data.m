% Calculate the number of samples in the dataset
numSamples = height(data);

% Shuffle the indices of the dataset
rng(123); % Set random seed for reproducibility
shuffledIdx = randperm(numSamples);

% Define the percentage of data to use for training
trainPercentage = 0.8; % 80% training, 20% testing

% Calculate the number of samples for training
numTrainSamples = round(trainPercentage * numSamples);
 
% Split the shuffled indices into training and testing indices
trainIdx = shuffledIdx(1:numTrainSamples);
testIdx = shuffledIdx(numTrainSamples+1:end);
 
% Separate training and testing data
trainData = data(trainIdx, :);
testData = data(testIdx, :);
