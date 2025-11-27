N = 65536;
SIN_TABLE = zeros(N, 1);
for i = 1:N
    SIN_TABLE(i) = sin( ((i-1)/N) * 2*pi );
end

SIN_TABLE = single(SIN_TABLE);

format long g;
SIN_TABLE(42)

