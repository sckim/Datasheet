%
%[그림 7-15]를 만들기 위한 M-file.
%
%1998.2.19           By Lim Jong_Su
%

close all
clear all

x1=0:1/1000:1;
y1=exp(-5*x1).*sin(200*x1);
hl1=line(x1,y1,'color','r');       % hl1=plot(x1,y1,'color','r');에 해당!	      ▶ ③
y1_text=ylabel('y1');						
x1_text=xlabel('x1');						
ax1=gca;							                                                         % ▶ ④
set(y1_text,'rotation',0)
set(ax1,'xcolor','r','ycolor','r');
ax2=axes('pos',get(ax1,'pos'),'xaxislocation','top','yaxislocation','right',...  
   'color','none','xcolor','k','ycolor','k');                                        %  ▶ ⑤
x2=0+eps:1/1000:.1;
y2=cos(2*pi*10*x2);
hl2=line(x2,y2,'color','k','parent',ax2);
y2_text=ylabel('y2');
x2_text=xlabel('x2');
set(y2_text,'rotation',0)
xlimits=get(ax1,'xlim');
ylimits=get(ax1,'ylim');
xinc=(xlimits(2)-xlimits(1))/10;
yinc=(ylimits(2)-ylimits(1))/10;
set(ax1,'xtick',[xlimits(1):xinc:xlimits(2)],...
   'ytick',[ylimits(1):yinc:ylimits(2)])
grid on
