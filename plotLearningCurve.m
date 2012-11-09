function figHandle = plotLearningCurve(cellMatrix, classification, trainModel, testModel)
    m = numel(classification);
    incr = floor(m/20);
    testPortion = 10*incr + 1;
    
    trainErrors = zeros(10, 1);
    testErrors = zeros(10, 1);
    
    for m_train = incr:incr:testPortion
        trainMatrix = cellMatrix(1:m_train, :);
        trainClass = classification(1:m_train);
        testMatrix = cellMatrix(testPortion:end, :);
        testClass = classification(testPortion:end);
        
        
        model = trainModel(trainMatrix, trainClass);
        trainPrediction = testModel(trainMatrix, model);
        testPrediction = testModel(testMatrix, model);
        
        trainErrors(m_train/incr) = 1 - (sum(trainPrediction == trainClass) / numel(trainClass));
        testErrors(m_train/incr) = 1 - (sum(testPrediction == testClass) / numel(testClass));
        
    end

    figHandle = plot(incr:incr:testPortion, [trainErrors testErrors], 'LineWidth', 2);
    xlim([0 testPortion])
    xlabel('m (Training Examples)');
    ylabel('Error')
    legend('Training Error', 'Testing Error')

end

