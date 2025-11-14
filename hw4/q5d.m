u_exact = @(x) sin(pi.*x);
f_exact = @(x) (-pi.^2).*sin(pi.*x) - sin(pi.*x);

hs = [1/20 1/40 1/80 1/160];
err = zeros(size(hs));

for k = 1:length(hs)
    h = hs(k);
    x = (0:h:1)';
    N = length(x);

    e = ones(N,1);
    L = spdiags([e -2*e e], -1:1, N, N);
    L = (1/h^2)*L;

    A = L - speye(N);
    b = f_exact(x);

    ub1 = u_exact(0); ub2 = u_exact(h);
    ue1 = u_exact(1); ue2 = u_exact(1-h);
    alpha = ub1 - (ub2 - ub1);
    beta  = ue1 - (ue2 - ue1);
    b(1)   = b(1)   - alpha/h^2;
    b(end) = b(end) - beta/h^2;
    u_num = A\b;
    err(k) = max(abs(u_num - u_exact(x)));
end
disp(err)

