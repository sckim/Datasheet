clear all;
t=-3:0.01:3;    %출력할 시간축의 크기를 선택
R=1;C=0.1;         %R과 C의 값을 넣음
N=40;             %고조파의 차수를 선택함
dx0=0.5; h0=1;   %dx0, H(0)의 값을 넣음
w0=pi;
y = dx0*h0*ones(1,length(t));   %출력의 D.C. 성분
for  n=1:N
   dxn=1/n/pi*sin(n*pi/2);   %입력의 Fourier 계수 계산 
   hn=1/(R*C)*1/(j*n*pi + 1/R/C);  %회로의 주파수 응답 계산
   dyn=dxn*hn;
   y=y+dyn*exp(j*n*w0*t)+conj(dyn)*exp(-j*n*w0*t);                  %RC회로의 출력 y(t) 를 계산
end
figure
plot(t,y);   %출력 파형 도시
title('\bf{출력 y(t)}');xlabel('\bf{t}');
