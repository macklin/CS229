% Train logistic regression

m = numel(classification);

m_train = floor(m/2);

trainMatrix = cellMatrixF(1:m_train, 1:end);
trainClass = classification(1:m_train);

lrModel = trainLR(trainMatrix, trainClass);


%% Test logistic regression

testMatrix = cellMatrixF((m_train + 1):end, 1:end);
testClass = classification((m_train + 1): end);

prediction = testLR(testMatrix, lrModel);

printDiagnostics(testClass, prediction);

plotPCADiagnostics(testMatrix, testClass, prediction)