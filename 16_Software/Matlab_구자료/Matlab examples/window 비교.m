% 참고문헌
% Discrete-Time signal processing, Oppenheim
% pp 444
% 자세히 나와 았음

T=4;

N=100;
data=zeros(3*N,1);
data(N:2*N-1)=hanning(N);
subplot(T,2,1);
plot(data);
title('Hanning')
subplot(T,2,2);
plot(fftshift(abs(fft(data))));


data=zeros(3*N,1);
data(N:2*N-1)=hamming(N);
subplot(T,2,3);
plot(data);
title('Hamming')
subplot(T,2,4);
plot(fftshift(abs(fft(data))));

data=zeros(3*N,1);
data(N:2*N-1)=ones(N,1);
subplot(T,2,5);
plot(data);
title('Rectangle')
subplot(T,2,6);
plot(fftshift(abs(fft(data))));

data=zeros(3*N,1);
data(N:2*N-1)=blackman(N);
subplot(T,2,7);
plot(data);
title('Blackman')
subplot(T,2,8);
plot(fftshift(abs(fft(data))));

