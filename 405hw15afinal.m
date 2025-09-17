% part a

format long g

function dist = sdcircle(u, v, r, x, y)
    dist = sqrt((x - u).^2 + (y - v).^2) - r;
endfunction

% part b

x0 = linspace(-6, 6, 200);
y0 = linspace(-6, 6, 200);
[X, Y] = meshgrid(x0, y0);

sd1 = sdcircle(2, 2, 1.25, X, Y);
sd2 = sdcircle(-2, 2, 1.5, X, Y);
sd3 = sdcircle(0, -1, 3, X, Y);
sd_min = min(sd1, min(sd2, sd3));

% plot
figure;
hold on;
contour(X, Y, sd_min);

% style
set(gca, 'fontsize', 13)
[C, h] = contour(X, Y, sd_min, [0, 0], 'LineWidth', 3, 'r-');
xlabel('x', 'FontSize', 18);
ylabel('y', 'FontSize', 18);
grid on;
