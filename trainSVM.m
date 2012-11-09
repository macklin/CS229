function svmModel = trainSVM(trainMatrix, trainClass, options)
    addpath('lib/libsvm-3.12/matlab');
    if ~exist('options', 'var')
        options = '-t 0';
    end
    training_label_vector = trainClass;
    training_label_vector(training_label_vector ~= 1) = -1;
    training_instance_matrix = sparse(trainMatrix);
    svmModel = svmtrain(training_label_vector, training_instance_matrix, options);
end

