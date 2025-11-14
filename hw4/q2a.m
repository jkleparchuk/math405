L = 30;
h = 0.05;
x = 0:h:L-h;
N = length(x);

Tf = 20;
a = 1;

nu = 1.05;


k = nu * h;
Nt = ceil(Tf / k);

u0 = exp(-20*(x-2).^2) + exp(-(x-5).^2);
u1 = exp(-20*((mod(x-k,L))-2).^2) + exp(-((mod(x-k,L))-5).^2);

u_nm1 = u0;
u_n = u1;
u_np1 = zeros(1,N);

for n = 2:Nt
    ujp1 = circshift(u_n, -1);
    ujm1 = circshift(u_n, 1);
    u_np1 = u_nm1 - nu * (ujp1 - ujm1);
    u_nm1 = u_n;
    u_n = u_np1;

    if n == round(3/k)
        figure;
        plot(x, u_n, 'b-');
        hold on;
        xlabel('x', 'fontsize' , 16);
        ylabel('u(x, t)', 'fontsize' , 16);
        title(['Leap Frog Solution, t = 3, h = 0.05, \nu = 1.05'], 'fontsize' , 16);
        grid on;
        u_exact = exp(-20*((mod(x-3,L))-2).^2) + exp(-((mod(x-3,L))-5).^2);
        plot(x, u_exact, 'r--');
        legend('Numerical','Exact', 'fontsize' , 16);
    end
end

