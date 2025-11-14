pkg load image
u = imread('testpat_noblur.png');
u = double(u) / 255;
[n, n2] = size(u);


k = 0.5;
steps = 10;

for t = 1:steps
    u_ext = padarray(u, [1 1], 'replicate');
    u = u + k * (u_ext(1:end-2, 2:end-1) + u_ext(3:end, 2:end-1) + u_ext(2:end-1, 1:end-2) + u_ext(2:end-1, 3:end) - 4*u);
end

figure;
imagesc(u);
axis equal tight;
caxis([0 1]);
colormap(gray);
imwrite(u, 'blurred_k01.png');

win = 25;
center = round(n/2);
closeup = u(center-win:center+win, center-win:center+win);
figure;
imagesc(closeup); axis equal tight; caxis([0 1]);
colormap(gray);
imwrite(closeup, 'closeup_k01.png');

