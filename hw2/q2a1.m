pkg load symbolic;

% part a

x = sym('x');
xi = [0 1 4 6];

n = 4;
L = sym(zeros(1, n));

for i = 1:n
    Li = sym(1);
    for j = 1:n
        if j != i
            Li = Li * (x - xi(j)) / (xi(i) - xi(j));
        endif
    endfor
    L(i) = simplify(expand(Li));
    disp(['L', num2str(i-1), '=', char(L(i))]);
endfor

%part b

##fplot(L, [min(xi)-1, max(xi)+1]);
##grid on;
##hold on;
##legend({'L0', 'L1', 'L2', 'L3'}, 'fontsize', 18);
##title('Cardinal Polynomials', 'fontsize', 18);
##xlabel('x', 'fontsize', 18);
##ylabel('L_i(x)', 'fontsize', 18);
##hold off;

% part c

fxi = [2 1 3 0];

P = sym(0);
for i = 1:n
    P = P + fxi(i)*L(i);
endfor
P = simplify(expand(P));
disp(['P(x) = ', char(P)]);

% part d

fplot(P, [min(xi)-1, max(xi)+1],'b-');
hold on;
plot(xi, fxi, 'ro');
legend('Interpolant', 'Data Points', 'fontsize', 18);
title('Interpolant and Data Points', 'fontsize', 18);
xlabel('x', 'fontsize', 18);
ylabel('y', 'fontsize', 18);
grid on;
hold off;

