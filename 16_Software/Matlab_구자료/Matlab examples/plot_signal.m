function plot_signal(ti,tf,A,a,f,t1,fs)
%예제1.7의 신호에 대해 샘플링 주파수에 따른 그림을 도시함

t=ti:1/fs:tf;  %t를 ti부터 tf까지 fs의 주파수로 샘플링함
x=A*exp(-a*t).*cos(2*pi*f*t).*stepfun(t,t1);   %x(t) 계산
x1=A*exp(-a*t).*stepfun(t,t1); x2=-A*exp(-a*t).*stepfun(t,t1);

%포락선 표시를 위한 함수
figure
hold on;      %하나의 그림창에 그래프를 연속하여서 그림 
stem(t,x); title('x(t)의 샘플링 신호(fs1)');   %샘플링된 신호 도시
plot(t,x1,'--'); plot(t,x2,'--');   %포락선 도시