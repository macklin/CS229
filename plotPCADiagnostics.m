function plotPCADiagnostics(testMatrix, testClass, prediction)

X = testMatrix';
X = X - repmat(mean(X, 2), 1, size(X, 2));
X = X ./ repmat(var(X, 1, 2), 1, size(X, 2));

[U, ~, ~] = svd(X);

x1 = U(:, 1)' * X;
x2 = U(:, 2)' * X;

TPidxs = (prediction == 1) & (testClass == 1);
FPidxs = (prediction == 1) & (testClass ~= 1);
TNidxs = (prediction ~= 1) & (testClass ~= 1);
FNidxs = (prediction ~= 1) & (testClass == 1);

figure(1);
hold('on');
scatter(x1(testClass ~= 1), x2(testClass ~= 1), 'co');
scatter(x1(testClass == 1), x2(testClass == 1), 'r+');
hold('off');

figure(2);

hold('on');
scatter(x1(FNidxs), x2(FNidxs), 'co');
scatter(x1(TNidxs), x2(TNidxs), 'c+');
scatter(x1(TPidxs), x2(TPidxs), 'r+');
scatter(x1(FPidxs), x2(FPidxs), 'ro');
hold('off');


end