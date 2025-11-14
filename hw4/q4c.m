f = @(z) sin(z);
df = @(x) cos(x);
x = 0.33;
hs = logspace(-8, -1, 20);

ierror = zeros(size(hs));
cerror = zeros(size(hs));

for j = 1:length(hs)
    h = hs(j);
    imdf = imag(f(x + 1i*h)) / h;
    cndf = (f(x + h) - f(x - h)) / (2*h);

    ierror(j) = abs(imdf - df(x));
    cerror(j) = abs(cndf - df(x));
end

figure;
loglog(hs, ierror, 'ro-');
hold on;
loglog(hs, cerror, 'bo-');
xlabel('h', 'fontsize', 16);
ylabel('Error', 'fontsize', 16);
title('Convergence Study', 'fontsize', 16);
legend('Imaginary','Centered');
grid on;

