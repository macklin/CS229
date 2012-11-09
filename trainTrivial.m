function trivialModel = trainTrivial(~, trainClass)
    phi_good = sum(trainClass == 1) / numel(trainClass);
    trivialModel = {phi_good};
end

