u_exact = @(x) 0.5*cos(pi*x/2) + 1;
f = @(x) -0.5*(pi/2)^2*cos(pi*x/2) - (0.5*cos(pi*x/2) + 1);

hs = [];
errs = [];
for N = [16 32 64 128 256]
    x = linspace(0,1,N+1)';
    h = x(2)-x(1);
    u_exact_vec = u_exact(x);
    F = f(x);

    A = zeros(N+1,N+1);

    for i=2:N
        A(i,i-1) = 1/h^2;
        A(i,i)   = -2/h^2 - 1;
        A(i,i+1) = 1/h^2;
    end
    A(1,1) = -2/h^2 - 1;
    A(1,2) = 2/h^2;
    A(N+1,:) = 0; A(N+1,N+1) = 1; F(N+1) = 1;

    u_num = A\F;
    e = max(abs(u_num - u_exact_vec));
    hs = [hs h];
    errs = [errs e];
end

loglog(hs, errs, 'o-')
xlabel('h', 'fontsize', 16)
ylabel('Error', 'fontsize', 16)
title('Convergence Study', 'fontsize', 16)
grid on

