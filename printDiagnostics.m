function [accuracy, precision, recall] = printDiagnostics(testClass, prediction)
    accuracy = sum(prediction == testClass) / numel(testClass);

    TP = sum((prediction == 1) & (testClass == 1));
    FP = sum((prediction == 1) & (testClass ~= 1));
    FN = sum((prediction ~= 1) & (testClass == 1));

    % The following should hold
    % TP + FP == sum(prediction == 1)
    % TP + FN == sum(testClass == 1)
    
    precision = TP / (TP + FP);
    recall = TP / (TP + FN);
    
    fprintf('Accuracy:\t%0.3f\n', accuracy);
    fprintf('Precision:\t%0.3f\n', precision);
    fprintf('Recall:  \t%0.3f\n', recall);
end

