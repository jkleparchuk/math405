% Compute error at t=0.3 for different h values

a = 2;
Tf = 0.3;
h_values = [1/4, 1/8, 1/16, 1/32, 1/64, 1/128, 1/256];
errors = zeros(size(h_values));

for i = 1:length(h_values)
    h = h_values(i);

    x = 0:h:(1-h);
    x = x';
    N = length(x);

    %% IC
    u0 = sin(a*pi*x);

    %% Matrix L
    e = ones(size(x));
    L = spdiags([e -2*e e], [-1 0 1], N, N);
    L(1, N) = 1;  % periodic boundary conditions
    L(N, 1) = 1;
    L = (1/h^2) * L;

    k = 0.4*h^2;
    numsteps = ceil(Tf / k);
    k = Tf / numsteps;

    %% time loop
    u = u0;
    for n=1:numsteps
        % (unew - u) / k = u_xx
        % solve for unew and approx u_xx
        unew = u + k*(L*u);
        u = unew;
    end

    u_exact = sin(a*pi*x) * exp(-(a*pi)^2 * Tf);
    errors(i) = max(abs(u - u_exact));
end

%% Create table of results
fprintf('h\t\tError\t\tError Ratio\n');
fprintf('--------------------------------\n');
fprintf('%f\t%e\t', h_values(1), errors(1));
fprintf('-\n');
for i = 2:length(h_values)
    ratio = errors(i-1) / errors(i);
    fprintf('%f\t%e\t%.2f\n', h_values(i), errors(i), ratio);
end
