%
%이 예제는 menu.m, questdlg.m함수의 사용법을 설명하기 위한 것이다.
%
%1998.2.4    By Lim Jong_Su
%

line_color=['r','g','b'];
str='Yes';
t=-2*pi:1/100:2*pi;
y=sin(t);

while(1)
   if strcmp(str, 'Yes')
      k=menu('선의 색을 결정','red','green','blue');
      plot(t,y,line_color(k))
      str=questdlg('계속하기를 원합니까?','선택사항','Yes','No','No');      
   else
      break;
   end
end

close all