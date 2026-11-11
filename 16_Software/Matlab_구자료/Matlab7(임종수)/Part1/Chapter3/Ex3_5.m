function [avg,med]=Ex3_5(in)

%Ex3_5.m : 서브 함수를 이용하여 평균과 중간 값을 구하는 함수.

n=length(in);
avg=newmean(in,n);
med=newmedian(in,n);

%서브 함수들.
function a=newmean(in,n)
%평균을 계산한다.
a=sum(in)/n;

function m=newmedian(v,n)
%중간 값을 계산한다.

w=sort(v);
if rem(n,2)==1
   m=w((n+1)/2);
else
   m=(w(n/2)+w(n/2+1))/2;
end