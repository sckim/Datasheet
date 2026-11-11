% fourier series expansion
%
f = 500; c = 4/pi; dt = 5.0e-05;
tpts = (4.0e-3/5.0e-5) + 1;

for n = 1: 12
for m = 1: tpts
s1(n,m) = (4/pi)*(1/(2*n - 1))*sin((2*n - 1)*2*pi*f*dt*(m-1));
end
end

for m = 1:tpts
 a1 = s1(:,m);
 a2(m) = sum(a1);
end

f1 = a2';
t = 0.0:5.0e-5:4.0e-3;
clg
plot(t,f1)
xlabel('Time, s')
ylabel('Amplitude, V')
title('Fourier series expansion')

