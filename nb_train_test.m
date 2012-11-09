%% Train naive bayes

m = numel(classification);

m_train = floor(m/2);

trainMatrix = cellMatrix(1:m_train, :);
trainClass = classification(1:m_train);

nbModel = trainNB(trainMatrix, trainClass);

%% Test naive bayes

testMatrix = cellMatrix((m_train + 1):end, :);
testClass = classification((m_train + 1): end);

prediction = testNB(testMatrix, nbModel);

printDiagnostics(testClass, prediction);