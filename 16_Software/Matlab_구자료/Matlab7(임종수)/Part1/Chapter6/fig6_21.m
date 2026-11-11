%
% [그림 6-21]을 만드는 데, 이용되는 M-file.
% -> text.m함수의 사용 방법.
%
% 2002, 1, 28   By Lim Jong_Su
%

close all
clear all

t=0:pi/100:2*pi;
y=sin(t);
plot(t,y)
xlabel('t=0 to 2\pi','fontsize',16)
ylabel('sin(t)','fontsize',16)
title('\it{Value of the Sine from Zero to Two Pi}')
set(gcf,'color','w')
text(3*pi/4,sin(3*pi/4),'\bullet\leftarrowsin(t)=0.707')
set(gca,'nextplot','add')
plot(3*pi/4,sin(3*pi/4),'ro')
text(pi,sin(pi),'\leftarrowsin(t)=0')
text(5*pi/4,sin(5*pi/4),...
   'sin(t)=-0.707\rightarrow','Horizontalalignment','right')

set(gca,'nextplot','replace')