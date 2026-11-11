%Frequency response of CE Amplifier
%
%
rc=4e3; rb1=60e3; rb2=40e3; rs=100; rce=60e3;
re=1.5e3; rl=2e3; beta=150; vcc=10; vt=26e-3; vbe =0.7;
cc1=2e-6; cc2=4e-6; ce=150e-6;, rx=10; cpi=100e-12;
cmu=5e-12;

%  Ic is calculated
rb = (rb1 * rb2)/(rb1 + rb2);
vbb = vcc * rb2/(rb1 + rb2);
icq = beta * (vbb - vbe)/(rb + (beta + 1)*re);

% Calculation of low frequency poles
% using equations (12.67), (12.69) and (12.70)
rpi=beta * vt/icq;
rb_rpi=rpi * rb/(rpi + rb);
rin=rs + rb_rpi;
wl1=1/(rin * cc1);
rc_rce=rc * rce/(rc + rce);
wl2=1/(cc2 * (rl + rc_rce));
rb_rs=rb * rs/(rb + rs);
rx1=(rpi + rb_rs)/(beta + 1);
re_prime=re * rx1/(re + rx1);
wl3=1/(re_prime * ce);

% Calculate the low frequency zero using equation (12.72)
wz = 1/(re*ce);

% Calculate the high frequency pole using equation (12.74)
gm = icq/vt;
rbrs_prx = ( rb * rs/(rb + rs)) + rx;
rt = (rpi * rbrs_prx)/(rpi + rbrs_prx);
rl_rc = rl * rc/(rl + rc);
ct = cpi + cmu * (1 + gm * rl_rc);
wh = 1/(ct * rt);

% Midband gain is calculated
rcercrl = rce * rl_rc/(rce + rl_rc);
am = -beta * rcercrl * (rb/(rb + rpi)) * (1/(rin));

% Frequency response calculation using equation (12.65)
a4 = 1; a3 = wl1 + wl2 + wl3 + wh;
a2 = wl1*wl2 + wl1*wl3 + wl2*wl3 + wl1*wh + wl2*wh + wl3*wh;
a1 = wl1*wl2*wl3 +wl1*wl2*wh + wl1*wl3*wh + wl2*wl3*wh;
a0 = wl1*wl2*wl3*wh;
den=[a4 a3 a2 a1 a0];

b3 = am*wh;
b2 = b3*wz; b1 =0; b0 = 0;
num = [b3 b2 b1 b0];

w = logspace(1,10);
h = freqs(num,den,w);
mag = 20*log10(abs(h));
f = w/(2*pi);

% Plot the frequency response
semilogx(f,mag,'w')
title('Magnitude Response')
xlabel('Frequency, Hz')
ylabel('Gain, dB')
axis([1, 1.0e10, 0, 45])
