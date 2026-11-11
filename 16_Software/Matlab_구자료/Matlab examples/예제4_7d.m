t=-3:0.001:3;       	%시간의 범위를 설정함
N=40;                  			%고조파의 차수를 선택함
a0=0.5;         				%DC성분의 계수
w0=pi;          				%w0 = pi
xN=a0*ones(1,length(t));    %xN(t)의 DC성분  
for n=1:2:N
   an=2/n/pi*sin(n*pi/2);  %기수 Fourier 계수 cn 
   xN=xN+an*cos(n*w0*t); %각 차수마다 xN을 계산함
end
figure
plot(t,xN) %조파합성파형 xN을 도시함
title('합성 신호 xN(t)'); xlabel('t'); 
