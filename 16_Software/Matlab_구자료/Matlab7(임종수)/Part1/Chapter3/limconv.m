function z=limconv(x,h)
%
% limconv(x, h)    X와 H의 콘버루션(convolution)을 구하는 함수이다.
%
% 1998.1.30     By Lim Jong_Su
%
%

len_h=length(h);
len_x=length(x);
len=len_h+len_x-1;
inv_x=zeros(len+len_h-1,1);
inv_x(len_h:len_h-1+len_x)=x(end:-1:1);
% 벡터 x의 좌우에 len_h-1개 zero padding 하였다.
% 그리고, 그 결과를 역 정렬 시켰다. 

for i=0:len_x-1+len_h-1;
   z(i+1)=sum(inv_x(len_h-1+len_x-i:end-i).*h(:));
end