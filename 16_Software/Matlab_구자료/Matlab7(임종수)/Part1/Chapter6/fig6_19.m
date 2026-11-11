%
%이 프로그램은 [그림 6-19]에 대한 것이다.
%우선, [그림 6-18]을 만든다.
%이제, mouse를 figure안으로 옮겨서, 임의의 선을 클릭하면, 선의
%style은 붉은 점선으로 바뀐다.
%
% 2002, 1, 28       By Lim Jong Su
%

t=-2*pi:1/100:2*pi; 
y1=sin(t); 
y2=cos(t); 
h_line=plot(t,y1,'k',t,y2,'k');  
%'k'는 검은 색을 의미한다.

linestylechange='set(gco,''color'',''r'',''Linestyle'','':'')'; 
%단일 인용부호가 두번 사용 된데 주의!
%gco는 [그림 6-11]에 대한 내용 설명 참고.
set(gca,'xlim', [min(t) max(t)],'ylim',[-1.5 1.5])
set(h_line,'buttondownfcn',linestylechange)  
% Figure Object의 CloseRequestFcn을 사용하는 방법과 동일하다.