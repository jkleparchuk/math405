mu = 0.012277471;
mucomp = 1 - mu;
y10 = 0.994;
v10 = 0;
y20 = 0;
v20 = -2.00158510637908252240537862224;
Y0 = [y10; v10; y20; v20];

t0 = 0;
tend = 17.0652165601579625588917206249;
N = 36000;
tspan = linspace(t0, tend, N+1);

Y = zeros(4, N+1);
Y(:,1) = Y0;


function dYdt = tbp(t, Y)
    mu = 0.012277471;
    mucomp = 1 - mu;
    y1 = Y(1);
    v1 = Y(2);
    y2 = Y(3);
    v2 = Y(4);
    D1 = ((y1 + mu)^2 + y2^2)^(3/2);
    D2 = ((y1 - mucomp)^2 + y2^2)^(3/2);
    dy1 = v1;
    ddy1 = y1 + 2*v2 - mucomp*(y1 + mu)/D1 - mu*(y1 - mucomp)/D2;
    dy2 = v2;
    ddy2 = y2 - 2*v1 - mucomp*y2/D1 - mu*y2/D2;
    dYdt = [dy1; ddy1; dy2; ddy2];
end


h = (tend-t0)/N;
for i = 1:N
    Y(:,i+1) = Y(:,i) + h * tbp(tspan(i), Y(:,i));
end

figure(1);
set(gca, 'fontsize', 18)
plot(Y(1,:), Y(3,:))
xlabel('y_1', 'fontsize', 18);
ylabel('y_2', 'fontsize', 18);
title('Forward Euler: y_1 vs y_2', 'fontsize', 18)
grid on


%part b

AbsTol = 1e-12;
RelTol = 1e-9;

options = odeset('AbsTol', AbsTol, 'RelTol', RelTol);
[t_ode45, Y_ode45] = ode45(@tbp, tspan, Y0, options);

figure(2);
hold on;
plot(Y_ode45(:,1), Y_ode45(:,3));
xlabel('y_1', 'fontsize', 18);
ylabel('y_2', 'fontsize', 18);
title('ode45: y_1 vs y_2', 'fontsize', 18);
hold off;
grid on;

%part d

figure(3);
timesteps = diff(sol.x);
hist(timesteps, 100)
xlabel('Step size', 'fontsize', 18)
ylabel('Frequency', 'fontsize', 18)
title('ode45 step sizes', 'fontsize', 18)
grid on

length(timesteps)



