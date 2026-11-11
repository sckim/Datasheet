%
% Animation에 대한 예제 :  
%
% 1998.2.21       By Lim Jong_Su
%

close all
clear all

w=1;
x=-2*pi:1/100:2*pi;
y=sinc(w*x);
K=MENU('EraseMode choice : ','Xor','Normal','Background','None');
mode=str2mat('Xor','Normal','Background','None');
fig_size =[121   208   560   346];
figure('pos',fig_size);
h=plot(x,y,'erasemode',mode(K,:));
set(gcf,'color','w')
title(['Animation Type : ' mode(K,:)],'fontsize',12);
for index=1:2:20
   y=sinc(index*x);
   set(h,'ydata',y)
   drawnow  %Figure window를 update하는 함수.
end
