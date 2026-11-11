%
% AREA.M    Area.m 그래픽 함수의 사용 방법에 대한 예제!
%
% 1998.2.24     By Lim Jong_Su
%

close all

sales=[51.6 82.4 90.8 59.1 47.0];            %판매 지수
profit=[19.3 34.2 61.4 50.5 29.4];            %이익 지수
years=90:94;

fig_size=[157   151   470   351];                %Figure의 크기 지정.

%h_sales=area(years, sales,'facecolor',[.8 .8 .8]);  	   		     ▶ ①
h_sales=area(years, sales);                       	                      % ▶ ②
set(h_sales,'facecolor',[.8 .8 .8]);                   	                   % ▶ ③
set(gcf,'pos',fig_size)
set(gcf,'color','w')
hold on
%h_profit=area(years,profit,'facecolor',[.3 .3 .3]);     		          ▶ ①
h_profit=area(years,profit);                        		                   % ▶ ②
set(h_profit,'facecolor',[.3 .3 .3]);                  		                  % ▶ ③
hold off
set(gca,'xtick',[90:94]);
set(gca,'layer','top')
grid on
xlabel('\bf{years}','fontsize',12)
ylabel('\bf{Expenses} \rm{+} \bf{profits} \rm{=} \bf{Sales} \rm{in 1,000''s}',...
   'fontsize',12)
