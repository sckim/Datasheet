% Frequency response of lowpass circuit
%
c = 1e-9; r1 = 2e3;
r2 = [100e3, 300e3, 500e3];
n1 = -1/(c*r1); d1 = 1/(c*r2(1));
num1 = [n1]; den1 = [1 d1];
w = logspace(-2,6);
h1 = freqs(num1,den1,w);
f = w/(2*pi);
d2 = 1/(c*r2(2)); den2 = [1 d2];
h2 = freqs(num1, den2, w);
d3 = 1/(c*r2(3)); den3 = [1 d3];
h3 = freqs(num1,den3,w);
semilogx(f,abs(h1),'w',f,abs(h2),'w',f,abs(h3),'w')
xlabel('Frequency, Hz')
ylabel('Gain')
axis([1.0e-2,1.0e6,0,260])
text(5.0e-2,35,'R2 = 100 Kilohms')
text(5.0e-2,135,'R2 = 300 Kilohms')
text(5.0e-2,235,'R2 = 500 Kilohms')
title('Integrator Response')
