function prediction = testNB(testMatrix, nbModel)
    phi_goodDist = nbModel{1};
    phi_badDist = nbModel{2};
    phi_good = nbModel{3};
    log_pGood = log(phi_good) + sum(testMatrix .* repmat(log(phi_goodDist), [size(testMatrix, 1) 1]), 2);
    log_pBad = log(1 - phi_good) + sum(testMatrix .* repmat(log(phi_badDist), [size(testMatrix, 1) 1]), 2);

    prediction = log_pGood > log_pBad;
end

