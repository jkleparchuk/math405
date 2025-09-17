%% Demo01:
%
% Goal: Approximately solve the heat eqn u_t = u_xx
% on 0 < x < 1, with IC u0 = sin(pi*x).
%
% now with dirichlet BC.
%

Tf = 0.3;
h_values = [1/4, 1/8, 1/16, 1/32, 1/64, 1/128, 1/256];
errors = zeros(size(h_values));


for i = 1:length(h_values)
  %% choose a spatial discretization
  h = h_values(i);
  x = h:h:(1-h);  x = x';
  N = length(x)

  %% IC
  u0 = sin(pi*x);

  %% Matrix L
  e = ones(size(x));
  L = spdiags([e -2*e e], [-1 0 1], N, N);
  L = (1/h^2) * L;
  % figure(2); spy(L)

  k = 0.4*h^2
  numsteps = ceil(Tf / k);
  k = Tf / numsteps;

  %% time loop
  u = u0;
  for n=1:numsteps
    unew = u + k*(L*u);
    u = unew;
   end

  u_exact = sin(pi*x) * exp(-pi^2 * Tf);
  errors(i) = max(abs(u - u_exact));
end

% table of results
fprintf('h\t\tError\t\tError Ratio\n');
fprintf('--------------------------------\n');
fprintf('%f\t%e\t', h_values(1), errors(1));
fprintf('-\n');
for i = 2:length(h_values)
    ratio = errors(i-1) / errors(i);
    fprintf('%f\t%e\t%.2f\n', h_values(i), errors(i), ratio);
end

% plot
figure(1);
loglog(h_values, errors, 'bo-');
set(gca, 'fontsize', 18)
hold on;

% best fit line
log_h = log10(h_values);
log_error = log10(errors);

p = polyfit(log_h, log_error, 1);
slope = p(1);
intercept = p(2);

h_fit = logspace(log10(h_values(1)), log10(h_values(end)), 100);
error_fit = 10.^(intercept + slope*log10(h_fit));

loglog(h_fit, error_fit, 'r-');

% style
xlabel('h', 'FontSize', 18);
ylabel('Max Error at t=0.3', 'FontSize', 18);
legend('Error', sprintf('Best Fit Line (slope = %.2f)', slope), 'FontSize', 15);
grid on;
