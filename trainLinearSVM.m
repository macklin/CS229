function linSVMModel = trainLinearSVM(trainMatrix, trainClass)
    addpath('lib/liblinear-1.92/matlab');
    training_label_vector = trainClass;
    training_label_vector(training_label_vector ~= 1) = -1;
    training_instance_matrix = sparse(trainMatrix);
    linSVMModel = train(training_label_vector, training_instance_matrix);
end

