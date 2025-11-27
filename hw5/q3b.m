Ns = [32, 64, 128, 256, 512];
eignums = [2, 12, 22];
errs = zeros(3, 5);
hs = zeros(1, 5);

for j = 1:length(Ns)
    N = Ns(j);
    L = 2*pi;
    h = L/N;
    hs(j) = h;

    n_int = N - 1;
    e = ones(n_int, 1);
    A = spdiags([e -2*e e], -1:1, n_int, n_int) / h^2;

    if n_int < 25
       num_calc = n_int;
    else
       num_calc = 25;
    end

    [V, D] = eigs(A, num_calc, 'sm');
    lambda = diag(D);

    [lambda_sorted, sort_idx] = sort(abs(lambda));
    sorted_eigs = lambda(sort_idx);

    for i = 1:length(eignums)
        k = eignums(i);
        lambda_num = sorted_eigs(k);

        lambda_exact = -(k/2)^2;
        errs(i, j) = abs(lambda_num - lambda_exact);
    end
end

figure;
loglog(hs, errs(1, :), 'bo-');
hold on;
loglog(hs, errs(2, :), 'rs-');
loglog(hs, errs(3, :), 'gd-');
grid on;
xlabel('h', 'fontsize', 16);
ylabel('Error', 'fontsize', 16);
title('Convergence of Eigenvalues', 'fontsize', 16);
legend('2nd', '12th', '22nd', 'fontsize', 16);

