% 
num = [2];
den = [1.05e-4 1];
w = logspace(1,5);
h = freqs(num,den,w);
f = w/(2*pi);
mag = 20*log10(abs(h));  % magnitude in dB

semilogx(f,mag)
title('Lowpass Filter Response')
xlabel('Frequency, Hz')
ylabel('Gain in dB')
