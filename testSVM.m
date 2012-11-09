function prediction = testSVM(testMatrix, svmModel)
    addpath('lib/libsvm-3.12/matlab');
    testing_label_vector = zeros(size(testMatrix, 1), 1);
    testing_label_vector(testing_label_vector ~= 1) = -1;
    
    testing_instance_matrix = sparse(testMatrix);
    
    [svmpredicted_label, ~, ~] = ...
        svmpredict(testing_label_vector, testing_instance_matrix, svmModel);
    
    prediction = svmpredicted_label;
    prediction(prediction < 0) = 0;
end

