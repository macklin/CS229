function knnModel = trainKNN(trainMatrix, trainClass, k)
    if ~exist('k', 'var')
        k = 1;
    end

    goodMatrix = trainMatrix(trainClass == 1, :);
    badMatrix = trainMatrix(trainClass ~= 1, :);
    badMatrix = badMatrix(1:size(goodMatrix, 1), :);
    
    knnModel = {goodMatrix, badMatrix, k};
end

