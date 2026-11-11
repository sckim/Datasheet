clear all;
R=1; C=1;           %R과 C의 값을 넣음
N=40;                %고조파의 차수를 선택함
c0=0.5; h0=1;      %c0, H(0)의 값을 넣음
w0=pi;
for  n=1:2:N    
   c(n)=2/n/pi*sin(n*pi/2);  %x(t)의 기수 Fourier 계수 cn 
   c(n+1)=0;                    %x(t)의 우수 Fourier 계수 cn 
end
for  n=1:N
   hn=1/(R*C)*1/(j*n*w0 + 1/R/C);  %회로의 주파수 응답 계산
   a_y(n)=abs(c(n)*hn);  %출력 파형의 진폭 스펙트럼 계산
   p_y(n)=angle(c(n))+angle(hn);
   ampHN(n)=abs(hn);
   angleHN(n)=angle(hn);
end
a_y = [c0*h0 a_y];
p_y = [0 p_y];
n=0:40;
figure
subplot(2,1,1);stem(n,a_y); 
%입력 파형의 주파수응답을 도시
title('\bf{진폭 스펙트럼}'); xlabel('\bf{n}'); grid on;
subplot(2,1,2);stem(n,p_y);  
title('\bf{위상 스펙트럼}'); xlabel('\bf{n}'); grid on;
