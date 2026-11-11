%
%SINC   sinc신호를 만들어 내는 M-file.
%--->배열만 이용한 경우!
%
%1997.1.25        By Lim Jong_Su
%

t=(-2:1/1000:2)';
y=zeros(size(t));

t_pos=find(t==0);
t(t_pos)=[];

y(1:end-1)=sin(pi*t)./(pi*t);

y(t_pos+1:end)=y(t_pos:end-1);
t(t_pos+1:end+1)=t(t_pos:end);
t(t_pos)=0;
y(t_pos)=1;

plot(t,y)