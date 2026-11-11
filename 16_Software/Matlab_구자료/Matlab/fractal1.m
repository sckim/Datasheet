N=1000
x=1:N;
w=randn(1,N);
W=fft(w);
c=1.9
Y=(1-exp(-j*2*pi/N)).^(c/2).*W;
y=ifft(Y);
plot(x,y);