yexact = @(t) 12 ./ (3 + exp(4*t));
A = @(y) y.^2;
B = @(y) -4*y;
f = @(y) A(y) + B(y);

function y1 = rk4(func,y0,k)
    k1 = func(y0);
    k2 = func(y0 + 0.5*k*k1);
    k3 = func(y0 + 0.5*k*k2);
    k4 = func(y0 + k*k3);
    y1 = y0 + k*(k1 + 2*k2 + 2*k3 + k4)/6;
end

function y = rk4integrate(func,y0,T,k)
    Nt = round(T/k);
    y = y0;
    t = 0;
    for n = 1:Nt
        y = rk4(func,y,k);
        t = t + k;
    end
end

function y = opsplit(A,B,y0,T,k)
    Nt = round(T/k);
    y = y0;
    for n = 1:Nt
        yA = rk4(A, y, k);
        yB = rk4(B, yA, k);
        y = yB;
    end
end

function y = strangsplit(A,B,y0,T,k)
    Nt = round(T/k);
    y = y0;
    for n = 1:Nt
        yB = rk4(B, y, k/2);
        yA = rk4(A, yB, k);
        yB2 = rk4(B, yA, k/2);
        y = yB2;
    end
end

y0 = 3;
T = 2;
tsteps = 2.^-(2:7);
Nsteps = 2 ./ tsteps;
errrk4 = zeros(size(tsteps));
errop = zeros(size(tsteps));
errstrang = zeros(size(tsteps));
ytexact = yexact(T);

for i = 1:length(tsteps)
    k = tsteps(i);

    yrk4 = rk4integrate(f, y0, T, k);
    yop = opsplit(A, B, y0, T, k);
    ystrang = strangsplit(A, B, y0, T, k);

    errrk4(i) = abs(yrk4 - ytexact);
    errop(i) = abs(yop - ytexact);
    errstrang(i) = abs(ystrang - ytexact);
end

figure;
loglog(Nsteps, errrk4, 'ro-');
hold on;
loglog(Nsteps, errop, 'go-');
loglog(Nsteps, errstrang, 'bo-');
xlabel('N', 'fontsize', 16);
ylabel('Error', 'fontsize', 16);
legend(['RK4'],['Operator Splitting'],['Strang Splitting'], 'location','southwest');
title('Convergence Studies', 'fontsize', 16);
grid on;
hold off;


