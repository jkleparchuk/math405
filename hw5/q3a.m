N = 64;
L = 2*pi;
h = L/N;
x = linspace(0, L, N+1)';

e = ones(63, 1);
A = spdiags([e -2*e e], -1:1, 63, 63) / h^2;

[V, D] = eigs(A, 25, 'sm');
lambda = diag(D);

[lambda_sorted, sort_idx] = sort(abs(lambda));

k = 22;
idx_22 = sort_idx(k);
v_num_int = V(:, idx_22);
v_num = [0; v_num_int; 0];

u_exact = sin(k * x / 2);

v_num = v_num / max(abs(v_num));
u_exact = u_exact / max(abs(u_exact));

if sign(v_num(2)) ~= sign(u_exact(2))
    v_num = -v_num;
end

figure;
plot(x, v_num, 'bo--');
hold on;
plot(x, u_exact, 'ro-');
xlabel('x', 'fontsize', 16);
ylabel('u(x)', 'fontsize', 16);
title('22nd Eigenvector vs Exact', 'fontsize', 16);
legend('Numerical', 'Exact', 'fontsize', 16);
grid on;

