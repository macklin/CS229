function prediction = testLR(testMatrix, lrModel)
    theta = lrModel{1};
    
    prediction = round(glmval(theta, testMatrix, 'logit'));
end

