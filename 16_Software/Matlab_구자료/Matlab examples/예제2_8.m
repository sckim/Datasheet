t=-2:0.01:4; %그래프를 그릴 범위를 설정함 
x=stepfun(t,-1)-stepfun(t,1);  %x(t) = u(t+1) - u(t-1)
h=(-t+3).*(stepfun(t,0)-stepfun(t,3));  %h(t) = (-t+3)(u(t) - u(t-3))
y=conv(x,h)*0.01;   % convolution 수행  y(t) = x(t)*h(t)
tt=-4:0.01:8;   % y(t)를 그릴 범위를 설정함 
figure
subplot(3,1,1);plot(t,x);   %x(t) 를 도시함
title('x(t)','fontsize',12);axis([-4 6 0 5]);
subplot(3,1,2);plot(t,h);   %h(t)를 도시함
title('h(t)','fontsize',12);axis([-4 6 0 5]);
subplot(3,1,3);plot(tt,y)   %y(t)를 도시함
title('y(t)','fontsize',12);axis([-4 6 0 5]);
