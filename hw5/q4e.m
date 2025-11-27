N = 65536;
SIN_TABLE = zeros(N, 1);
for i = 1:N
    SIN_TABLE(i) = sin( ((i-1)/N) * 2*pi );
end

SIN_TABLE = single(SIN_TABLE);

format long g;

yaw = single(166.02812)
const1 = single(0.017453292)
const2 = single(10430.378)
value = yaw * const1
% note: rem is remainder, int64 converts to integer
% the exact placement of brackets here matters
sindex = rem(int64(value * const2), N) + 1
cindex = rem(int64(value * const2 + 16384), N) + 1
s = SIN_TABLE(sindex)
c = SIN_TABLE(cindex)

yaw0 = single(5850000);
max_val = -Inf;
best_yaw = NaN;

for j = 0:1000000-1
    yaw = single(yaw0 + j);

    value = yaw * const1;
    sindex = rem(int64(value * const2), N) + 1;
    cindex = rem(int64(value * const2 + 16384), N) + 1;

    s = SIN_TABLE(sindex);
    c = SIN_TABLE(cindex);
    test_val = c^2 + s^2;

    if test_val > max_val
        max_val = test_val;
        best_yaw = yaw;
    end
end

fprintf('Best yaw = %.8g single; Max boost = %.8g\n', best_yaw, max_val);
