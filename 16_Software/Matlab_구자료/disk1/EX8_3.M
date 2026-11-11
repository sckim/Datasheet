% synthesis of g(t) using exponential
% Fourier series expansion
%
dt = 0.05;
tpts = 8.0/dt +1;
cst = exp(2) - exp(-2);
for n = -10:10
  for m = 1:tpts

    g1(n+11,m) = ((0.5*cst*((-1)^n))/(2+j*n*pi))*(exp(j*n*pi*dt*(m-1)));
  end
end

for m = 1: tpts
 g2 = g1(:,m);
 g3(m) = sum(g2);
end

g = g3';
t = -4:0.05:4.0;
plot(t,g)
xlabel('Time, s')
ylabel('Amplitude')
title('Approximation of g(t)')
