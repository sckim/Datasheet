%
%이 예제는 menu.m함수 사용법을 설명하기 위한 것이다.
%
%1998.2.4    By Lim Jong_Su
%

line_color=['r','g','b'];
str='y';

t=-2*pi:1/100:2*pi;
y=sin(t);

while(1)
   if str=='y'
      k=menu('선의 색을 결정','red','green','blue');
      plot(t,y,line_color(k))
      R=input('계속하려면 ''y''를 type!  :','s');
      str=lower(R);
   else
      break;
   end
end
close all