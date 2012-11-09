function prediction = testTrivialRand(testMatrix, phi_good)
    nRows = size(testMatrix, 1);
    prediction = zeros(nRows, 1);
    prediction(rand(nRows, 1) <= phi_good) = 1;
end

