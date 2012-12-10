function plotPCA(X, y)

X = X';
X = X - repmat(mean(X, 2), 1, size(X, 2));
X = X ./ repmat(var(X, 1, 2), 1, size(X, 2));

[U, ~, ~] = svd(X);

x1 = U(:, 1)' * X;
x2 = U(:, 2)' * X;

hold('on');
scatter(x1(y ~= 1), x2(y ~= 1), 'c.');
scatter(x1(y == 1), x2(y == 1), 'r+');
hold('off');

legend('Bad', 'Good')
xlabel('u_1');
ylabel('u_2');

end