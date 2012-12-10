function lrModel = trainLR(trainMatrix, trainClass)

    theta = glmfit2(trainMatrix, [trainClass ones(numel(trainClass), 1)], 'binomial', 'link', 'logit');
    
    lrModel = {theta};
end

