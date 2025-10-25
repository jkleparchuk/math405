format long g

error = [];
hs = [];
for n = [10, 20, 40, 80, 160, 320]
    h = 1/(n+1);
    x = (h:h:1-h)';
    f = (log(3)^2 - 1) * 3.^x;
    uexact = 3.^x;

    main = -2 * ones(n,1);
    off = ones(n-1,1);
    L = (diag(main) + diag(off,1) + diag(off,-1)) / h^2;
    A = L - eye(n);
    f(1) = f(1) - 1 / h^2;
    f(n) = f(n) - 3 / h^2;

    unumeric = A \ f;
    error(end+1) = max(abs(unumeric - uexact));
    hs(end+1) = h;
end

loglog(hs, error, 'o-');
xlabel('h', 'fontsize', 18);
ylabel('Max Error', 'fontsize', 18);
title('Error vs h', 'fontsize', 18);
grid on;

