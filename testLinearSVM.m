function prediction = testLinearSVM(testMatrix, linSVMModel)
    addpath('lib/liblinear-1.92/matlab');
    testing_label_vector = zeros(size(testMatrix, 1), 1);
    testing_label_vector(testing_label_vector ~= 1) = -1;
    
    testing_instance_matrix = sparse(testMatrix);
    
    [linpredicted_label, ~, ~] = ...
        predict(testing_label_vector, testing_instance_matrix, linSVMModel);
    
    prediction = linpredicted_label;
    prediction(prediction < 0) = 0;
end

