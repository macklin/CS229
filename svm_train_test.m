%% Train SVM

% addpath('lib/liblinear-1.92/matlab');
% addpath('lib/libsvm-3.12/matlab');


m = numel(classification);

m_train = floor(m/2);

trainMatrix = cellMatrix(1:m_train, :);
trainClass = classification(1:m_train);

linSVMModel = trainLinearSVM(trainMatrix, trainClass);
svmModel = trainSVM(trainMatrix, trainClass);%, '-t 0');


%% Test SVM

testMatrix = cellMatrix((m_train + 1):end, :);
testClass = classification((m_train + 1): end);

prediction = testLinearSVM(testMatrix, linSVMModel);
printDiagnostics(testClass, prediction);

prediction = testSVM(testMatrix, svmModel);
printDiagnostics(testClass, prediction);