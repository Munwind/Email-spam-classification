numSamples = height(data);

rng(123);
shuffledIdx = randperm(numSamples);

trainPercentage = 0.8;

numTrainSamples = round(trainPercentage * numSamples);
 
% Split the shuffled indices into training and testing indices
trainIdx = shuffledIdx(1:numTrainSamples);
testIdx = shuffledIdx(numTrainSamples+1:end);
 
% Separate training and testing data
trainData = data(trainIdx, :);
testData = data(testIdx, :);
