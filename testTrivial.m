function prediction = testTrivial(testMatrix, trivialModel)
    phi_good = trivialModel{1};
    nRows = size(testMatrix, 1);
    if phi_good < 0.5
        prediction = zeros(nRows, 1);
    else
        prediction = ones(nRows, 1);
    end
end

