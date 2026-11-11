clear all;        %사용되었던 모든 변수를 지움
t=-3:0.001:3;    			%시간축을 설정함
N=40;              			%고조파의 차수를 선택함
w0=pi;
c0=0.5;                         %DC 성분의 Fourier 계수 c0 
for  n=1:2:N
   c(n)=2/n/pi*sin(n*pi/2);  %기수 Fourier 계수 cn 
   c(n+1)=0;                    %우수 Fourier 계수 cn 
end
c=[c0 c];
f=0:length(c)-1;   %주파수 축을 설정함
figure
subplot(2,1,1);stem(f,abs(c));      %진폭 스펙트럼을 그림
title('\bf{진폭 스펙트럼}');xlabel('\bf{n}'); 
subplot(2,1,2);stem(f,angle(c));    %위상 스펙트럼을 그림
title('\bf{위상 스펙트럼}');xlabel('\bf{n}'); 
