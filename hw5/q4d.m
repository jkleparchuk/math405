clear

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

c^2 + s^2 - 1
