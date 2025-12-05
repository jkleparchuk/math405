clear;
format long;

N  = 128;
hx = 1/N;
hy = 1/N;
x1d = 0:hx:2;
y1d = 0:hy:1;
[xx,yy] = meshgrid(x1d, y1d);

eps = 1/100;
xs  = 1.5;
ys = 0.6;

core = exp(-((xx - xs).^2 + (yy - ys).^2) / eps);

I = trapz(y1d, trapz(x1d, core, 2));

a = eps / I

