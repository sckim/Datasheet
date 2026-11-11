k=0:50; %신호를 51개 까지 표현함.
sk=1.02.^k; %입력 신호 s[k]
vk=0.5*cos(2*pi*k/8+pi/4);  %잡음신호 v[k]
xk=sk+vk;   %수신신호 x[k]
hk=ones(7,1)/7;  %7점 이동 평균 필터의 임펄스 응답 h[k]
yk=conv(hk,xk);   %x[k]와 h[k]의 convolution 수행
figure
subplot(4,1,1);stem(k,sk); %송신신호 s[k] 그림
title('s[k]','fontsize',12);
subplot(4,1,2);stem(k,xk); %수신신호 x[k] 그림
title('x[k]','fontsize',12);
subplot(4,1,3);stem(k,yk(1:length(k)));%출력신호 y[k] 그림
title('y[k]','fontsize',12);
subplot(4,1,4);stem(k(1:length(hk)),hk); %필터의 임펄스 응답 h[k]를 그림
title('h[k]','fontsize',12);
