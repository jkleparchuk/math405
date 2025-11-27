tol = 1e-3;
k = 22;
lambda_exact = -(k/2)^2;

L = 2*pi;
N = 64;

while true
    h = L / N;
    n_int = N - 1;
    e = ones(n_int, 1);
    A = spdiags([e -2*e e], -1:1, n_int, n_int) / h^2;

    [V, D] = eigs(A, 30, 'sm');
    lambda = diag(D);

    [~, sort_idx] = sort(abs(lambda));
    sorted_eigs = lambda(sort_idx);

    lambda_num = sorted_eigs(k);
    rel_err = abs(lambda_num - lambda_exact) / abs(lambda_exact);

    if rel_err < tol
        fprintf('approx h = %.4e\n', h);
        break;
    end
    N = N * 2;
end

