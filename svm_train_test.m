%% Train SVM

% addpath('lib/liblinear-1.92/matlab');
% addpath('lib/libsvm-3.12/matlab');


m = numel(classification);

m_train = floor(m/2);

trainMatrix = cellMatrix(1:m_train, :);
trainClass = classification(1:m_train);

% linSVMModel = trainLinearSVM(trainMatrix, trainClass);
% KL: fft 15 frames: 87.7% precision, 74.3% recall
%svmModel = trainSVM(trainMatrix, trainClass, '-t 1 -d 15 -c 600000 -r 1');
% KL: fft 15 frames, areamean > 150,: 52.4% precision, 90.7% recall
% svmModel = trainSVM(trainMatrix, trainClass, '-t 1 -d 15 -c 1500000 -r 1');
svmModel = trainSVM(trainMatrix, trainClass, '-t 2 -g 2 -c 128');

saveModel(svmModel, 'SVM', featsToKeep, timeCourseInfo, normParams, 'klmodel.mat')

%% Test SVM

testMatrix = cellMatrix((m_train + 1):end, :);
testClass = classification((m_train + 1): end);

% prediction = testLinearSVM(testMatrix, linSVMModel);
% printDiagnostics(testClass, prediction);

prediction = testSVM(testMatrix, svmModel);
printDiagnostics(testClass, prediction);