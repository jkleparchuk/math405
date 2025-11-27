pkg load image
img = double(imread('value20000.png'));

k = 0.1;
steps = 5;

u_blur = img;
for t = 1:steps
    img_ext = padarray(u_blur, [1 1], 'replicate');
    u_blur = u_blur + k * (img_ext(1:end-2, 2:end-1) + img_ext(3:end, 2:end-1) + img_ext(2:end-1, 1:end-2) + img_ext(2:end-1, 3:end) - 4*u_blur);
end

edge = img - u_blur;

result = img + edge;

result = min(max(result, 0), 255);

imshow(uint8(result));

minval = min(result(:));
maxval = max(result(:));
minval
maxval

