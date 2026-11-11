%
%SINC   sinc신호를 만들어 내는 M-file.
%
%1998.1.25        By Lim Jong_Su
%

t=(-2:1/1000:2)';
for index=1:length(t);
   if t(index)== 0
      y(index)=1;
   else
      y(index)=sin(pi*t)/(pi*t(index));
   end
end

plot(t,y)
