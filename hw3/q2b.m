format long g

f = [16 7 9];
xk = [0 1 4];
x = 0.9999;

function beta = bary(xk, x)
  n = length(xk);
  w = zeros(n,1);
  for k = 1:n
    w(k) = 1 / prod(xk(k) - xk([1:k-1 k+1:n]));
  end
  tol = 1e-14;
  special = find(abs(x - xk) < tol);
  if length(special) > 0
    beta = zeros(n,1);
    beta(special) = 1;
  else
    bot = sum(w ./ (x - xk(:)));
    beta = (w ./ (x - xk(:))) / bot;
  end
end

beta = bary(xk, x);
finterp = beta(1) * f(1) + beta(2) * f(2) + beta(3) * f(3)
beta

