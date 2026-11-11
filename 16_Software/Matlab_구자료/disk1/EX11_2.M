diary ex11_2.dat
% Poles and zeros, frequency response of Figure 11.13
%
%
c1 = 1e-7; c2 = 1e-3; r1 = 10e3; r2 = 10;

% poles and zeros
b1 = c2*r2;
a1 = c1*r1;
num = [b1 1];
den = [a1 1];
disp('the zero is')
z = roots(num)
disp('the poles are')
p = roots(den)

% the frequency response
w = logspace(-2,6);
h = freqs(num,den,w);
gain = 20*log10(abs(h));
f = w/(2*pi);
phase = angle(h)*180/pi;
subplot(211),semilogx(f,gain,'w');
xlabel('Frequency, Hz')
ylabel('Gain, dB')
axis([1.0e-2,1.0e6,0,22])
text(2.0e-2,15,'Magnitude Response')
subplot(212),semilogx(f,phase,'w')
xlabel('Frequency, Hz')
ylabel('Phase')
axis([1.0e-2,1.0e6,0,75])
text(2.0e-2,60,'Phase Response')

diary