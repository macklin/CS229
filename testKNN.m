function prediction = testKNN(testMatrix, knnModel)
    goodMatrix = knnModel{1};
    badMatrix = knnModel{2};
    k = knnModel{3};
    
    goodCorrs = sort(abs(corr(testMatrix', goodMatrix')), 2, 'descend');
    badCorrs = sort(abs(corr(testMatrix', badMatrix')), 2, 'descend');

    prediction = sum(goodCorrs(:, 1:k) > badCorrs(:, 1:k), 2) / k >= 0.5;
end

