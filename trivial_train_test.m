%% Train trivial classifier

m = numel(classification);

m_train = floor(m/2);

trainMatrix = cellMatrix(1:m_train, :);
trainClass = classification(1:m_train);

trivialModel = trainTrivial(trainMatrix, trainClass);

%% Test naive bayes

testMatrix = cellMatrix((m_train + 1):end, :);
testClass = classification((m_train + 1): end);

prediction = testTrivial(testMatrix, trivialModel);

printDiagnostics(testClass, prediction);