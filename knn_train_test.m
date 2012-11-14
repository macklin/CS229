%% Train KNN

m = numel(classification);

m_train = floor(m/2);

trainMatrix = cellMatrix(1:m_train, :);
trainClass = classification(1:m_train);

% knnModel = trainKNN(trainMatrix, trainClass, 5);
knnModel = trainKNN(svs, svsclass, 30);

%% Test KNN

testMatrix = cellMatrix((m_train + 1):end, :);
testClass = classification((m_train + 1): end);

prediction = testKNN(testMatrix, knnModel);

printDiagnostics(testClass, prediction);