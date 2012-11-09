function nbModel = trainNB(trainMatrix, trainClass)
    numTokens = size(trainMatrix, 2);

    goodMatrix = trainMatrix(trainClass == 1, :);
    badMatrix = trainMatrix(trainClass ~= 1, :);

    phi_goodDist = (sum(goodMatrix, 1) + 1) ./ (sum(goodMatrix(:)) + numTokens);
    phi_badDist = (sum(badMatrix, 1) + 1) ./ (sum(badMatrix(:)) + numTokens);

    phi_good = sum(trainClass == 1) / numel(trainClass);
    
    nbModel = {phi_goodDist, phi_badDist, phi_good};
end

