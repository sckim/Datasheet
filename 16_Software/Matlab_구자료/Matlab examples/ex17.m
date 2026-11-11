function ex17(ti,dt,tf,A,a,f,t1,fs)
  %예제1.7의 신호에 대해 각각의 샘플링 주파수에 따른 그림을 도시함

t=ti:dt:tf;  %시간 설정
x=A*exp(-a*t).*cos(2*pi*f*t).*stepfun(t,t1);   %x(t) 계산
x1=A*exp(-a*t).*stepfun(t,t1); x2=-A*exp(-a*t).*stepfun(t,t1);
   %신호의 포락선 표시를 위한 함수
figure
hold on;        
plot(t,x);title('x(t)');               %원 신호 x(t)를 도시함
plot(t,x1,'--'); plot(t,x2,'--');     %포락선 도시
plot_signal(ti,tf,A,a,f,t1,fs(1));   %fs(1)로 샘플링된 신호 도시  
plot_signal(ti,tf,A,a,f,t1,fs(2));   %fs(2)로 샘플링된 신호 도시  