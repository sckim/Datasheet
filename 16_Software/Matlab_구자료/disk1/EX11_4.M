% Frequency response of op amp
%
% poles are
p1 = 400*pi; p2 = 8e5*pi; p3 = 1.6e6*pi;
p = [p1 p2 p3];
% zeros
z = [0];
const = 2.62e21;
% convest poles and zeros to
% find the frequency response
a3 = 1;
a2 = p1 + p2 + p3;
a1 = p1*p2 + p1*p3 + p2*p3;
a0 = p1*p2*p3;
den = [a3 a2 a1 a0];
num = [const];
w = logspace(1,8);
h = freqs(num,den,w);
f = w/(2*pi);
g_db = 20*log10(abs(h));
semilogx(f,g_db)
title('Magnitude response')
xlabel('Frequency, Hz')
ylabel('Gain, dB')
