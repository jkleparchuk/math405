format bit;
x = single(16777208);

function y = next_single(x)
  assert(strcmp(class(x),'single'));
  bx = typecast(x, 'uint32');
  by = bx + 1;
  y = typecast(by, 'single');
end

for i = 1:20
  bits = dec2bin(typecast(x, 'uint32'), 32);
  fprintf('%s    %.7f\n', bits, x);
  x = next_single(x);
end




