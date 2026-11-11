% power spectral estimation of noisy signal
t = 0.0:0.002:0.5;
f1 =100;
% generate the sine portion of signal
x = sin(2*pi*f1*t);
% generate a normally distributed white noise
n = 0.5*randn(size(t));
% generate the noisy signal
y = x+n;
subplot(211), plot(t(1:50),y(1:50)),
title('Nosiy time domain signal')
% power spectral estimation is done
yfft = fft(y,256);
len = length(yfft);
pyy = yfft.*conj(yfft)/len;
f = (500./256)*(0:127);
subplot(212), plot(f,pyy(1:128)),
title('power spectral density'),
xlabel('frequency in Hz')

