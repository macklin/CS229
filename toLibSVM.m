function toLibSVM( cellMatrix, classification, fileName )
    addpath('lib/libsvm-3.12/matlab');

    features_sparse = sparse(cellMatrix);
    libsvmwrite(fileName, classification, features_sparse);
end

