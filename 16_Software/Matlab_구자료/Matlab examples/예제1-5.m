t = -3 : 0.01 : 3;  %시간 설정(시간을 -3 에서 3 까지 0.01씩 증가시킴)
x = t.^3;                           % x(t) = t^3
x1 = (-t).^3;                      % x1(t) = x(-t)
x2 = (-2*t).^3;                    % x2(t) = x( 2(-t) )
x3 = (-2*t+4).^3;                 % x3(t) = x( 2(-(t-2)))
subplot(4,1,1);
plot(t,x);axis([-3 3 -8 8]);title('x(t)');grid on;    
  %좌표축의 값을 횡축=-3 to 3, 종축=-8 to 8까지로 설정함.
subplot(4,1,2);
plot(t,x1);axis([-3 3 -8 8]);title('x(-t)');grid on;  
  %subplot을 이용하여 한 화면을 (4,1)로 등분하여 파형을 도시함
subplot(4,1,3);
plot(t,x2);axis([-3 3 -8 8]);title('x(-2t)');grid on;  
  %grid on : 좌표축에 안내선을 만들어줌.
subplot(4,1,4);
plot(t,x3);axis([-3 3 -8 8]);
title('y(t)=x(4-2t)');grid on;
  %plot(t,x) : 가로축을 t , 세로축을 x로하여 도시함.