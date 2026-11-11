%
% BAR.M & PLOT.M    두 개의 그래픽 함수들을 함께 사용하는 방법!
%
% 1998.2.24     By Lim Jong_Su
%

close all

TCE=[515 420 370 250 135 120 60 20];
temp=[29 23 27 25 20 23 23 27];
days=0:5:35;
fig_size=[157   151   470   351]     %Figure의 크기를 정하였다.
h=bar(days,temp);                  %Patch Object에 해당하는 handle, h를 돌려준다.
xlabel('\bf{Day}','fontsize',12)
ylabel('\bf{Temperture (^{o}C)}','fontsize',12)
set(h,'facecolor','c')                  %앞에서 "facecolor"에 대해서 설명하였다.
set(gcf,'color','w')
set(gcf,'pos',fig_size)
h1=gca;
h2=axes('pos',get(h1,'pos'));
plot(days,TCE,'linewidth',3,'color','k')
set(h2,'YAxisLocation','right','color','none','xticklabel',[])
set(h2,'xlim',get(h1,'xlim'),'layer','top')
set(gcf,'color','w')
set(gcf,'pos',fig_size)

grid on

ylabel('TCE 농도(PPM)')
title('\bf{Bioremediation}','fontsize',12)