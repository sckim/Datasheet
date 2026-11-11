B=[1 -2*cos(0.4*pi) 1];
A=[1 0 0];
figure(1)
pzmap(B,A);
axis([-1 1 -1 1]);
figure(2)
freqz(B,A,100,300);

t=0:1/300:5-1/300;
Sig1= 5*sin(2*pi*10*t)+cos(2*pi*60*t)+cos(2*pi*100*t);
f=linspace(0,300, length(Sig1));
plot(f,abs(fft(Sig1)));

Sig2=conv(Sig1, B);
f=linspace(0,300, length(Sig2));
plot(f,abs(fft(Sig2)));



