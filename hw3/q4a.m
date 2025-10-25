format long g

x0 = 1.2;
exact = sin(x0);

k = 0:0.5:8;
hs = 10.^(-k);
error = zeros(size(hs));

for i = 1:length(hs)
    h = hs(i);
    fpppp = (sin(x0-2*h) - 4*sin(x0-h) + 6*sin(x0) - 4*sin(x0+h) + sin(x0+2*h)) / h^4;
    error(i) = abs(fpppp - exact);
end

figure;
set(gca, 'fontsize', 18)
loglog(hs, error, 'bo-');
xlabel('h', 'fontsize', 18);
ylabel('Total Error', 'fontsize', 18);
title('f^{(4)} Error vs h', 'fontsize', 18);
grid on;

[min_error, idx] = min(error);
fprintf('Optimal h ≈ %.5e, minimum error ≈ %.5e\n', hs(idx), error(idx));

