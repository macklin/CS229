function prediction = testSVM(testMatrix, svmModel, options)
    addpath(fullfile(fileparts(mfilename('fullpath')),'lib/libsvm-3.12/matlab'));
        if ~exist('options', 'var')
        options = '-t 1 -d 15 -c 1e6 -r 1';
    end
    testing_label_vector = zeros(size(testMatrix, 1), 1);
    testing_label_vector(testing_label_vector ~= 1) = -1;
    
    testing_instance_matrix = sparse(testMatrix);
    
    [svmpredicted_label, ~, ~] = ...
        svmpredict(testing_label_vector, testing_instance_matrix, svmModel);
    
    prediction = svmpredicted_label;
    prediction(prediction < 0) = 0;
end

