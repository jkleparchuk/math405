% part a

n = 8;
x_plot = linspace(-1, 1, 1000);

x_cheb = cos(pi * (2*(0:7) + 1) / (2*n))';
x_equi = linspace(-1, 1, n);

p1 = ones(size(x_plot));
p2 = ones(size(x_plot));
for j = 1:n
    p1 = p1 .* (x_plot - x_cheb(j));
    p2 = p2 .* (x_plot - x_equi(j));
end

figure;
plot(x_plot, p1, 'b-');
hold on;
plot(x_plot, p2, 'r-');
plot(x_cheb, zeros(1, n), 'bo');
plot(x_equi, zeros(1, n), 'ro');
xlabel('x', 'fontsize', 18);
ylabel('\pi_1(x), \pi_2(x)', 'fontsize', 18);
legend('\pi_1(x) (Chebyshev)', '\pi_2(x) (Equispaced)', 'Chebyshev Roots', 'Equispaced Roots', 'fontsize', 14);
title('Chebyshev vs Equispaced', 'fontsize', 18);
grid on;

% part b

nb = 2:30;
p1max = zeros(size(nb));
p2max = zeros(size(nb));
x_dense = linspace(-1, 1, 10000);

for m = 1:length(nb)
    n = nb(m);

    x_cheb = cos(pi * (2*(0:(n-1)) + 1) / (2*n))';
    x_equi = linspace(-1, 1, n);

    p1pts = ones(size(x_dense));
    p2pts = ones(size(x_dense));

    for j = 1:n
        p1pts = p1pts .* (x_dense - x_cheb(j));
        p2pts = p2pts .* (x_dense - x_equi(j));
    end
    p1max(m) = max(abs(p1pts));
    p2max(m) = max(abs(p2pts));
end

fprintf('n \t max(|pi1|) \t max(|pi2|) \n');
fprintf('-----------------------------\n');
for i = 1:length(nb)
    fprintf('%d \t %.6e \t \t %.6e \n', nb(i), p1max(i), p2max(i));
end

% part c

figure;
semilogy(nb, p1max, 'b');
hold on;
semilogy(nb, p2max, 'r');
xlabel('n', 'fontsize', 18);
ylabel('Maximum', 'fontsize', 18);
legend('\pi_1', '\pi_2', 'fontsize', 18);
title('Max of |\pi_1(x)| and |\pi_2(x)| for n \in [2,30]', 'fontsize', 18);
grid on;

% part e

cheb_bound = 2*(0.52).^(nb);

figure;
semilogy(nb, p1max, 'b');
hold on;
semilogy(nb, p2max, 'r');
semilogy(nb, cheb_bound, 'g');
xlabel('n', 'fontsize', 18);
ylabel('Maximum', 'fontsize', 18);
legend({'\pi_1', '\pi_2','\pi_1 Bound'}, 'fontsize', 18);
title('\pi_1, \pi_2, and Estimated Bound', 'fontsize', 18);
grid on;



