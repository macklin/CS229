function svmModel = trainSVM(trainMatrix, trainClass, options)
    addpath(fullfile(fileparts(mfilename('fullpath')),'lib/libsvm-3.12/matlab'));
    if ~exist('options', 'var')
        options = '-t 1 -d 15 -c 1e6 -r 1';
    end
    training_label_vector = trainClass;
    training_label_vector(training_label_vector ~= 1) = -1;
    training_instance_matrix = sparse(trainMatrix);
    svmModel = svmtrain(training_label_vector, training_instance_matrix, options);
end

