tmax = 100; d = [0 tmax];
LW = 'linewidth'; MS = 'markersize';
opts = odeset('abstol',1e-10,'reltol',1e-10);
fun = @(t,u) [u(2); -u(1)./abs(u(1)).^3.1];
u0 = -1+1i;
v = 1;
uv = chebfun.ode113(fun,d,[u0; v],opts); uv = uv(:,1);
hold off, plot(0,0,'.r','markersize',24), hold on
plot(uv,LW,1.6), axis equal, grid on, shg
plot(uv(0:tmax),'.k',MS,16)

u = @(v) chebfun.ode113(fun,d,[u0; v],opts);

hold off, plot(0,0,'.r','markersize',24), hold on
for v = [.5 .75 1 1.5 2]
     uv = u(v); uv = uv(:,1); plot(uv,LW,1.6)
     plot(uv(0:tmax),'.k',MS,16)
end
axis([-3 3 -3 3]), axis square, grid on, shg

