function [avg,med]=Ex3_6(in)
% Ex3_6.m : 서브 함수를 이용하여 평균과 중간 값을 구하는 함수.

global n
n=length(in);
avg=newmean(in);
med=newmedian(in);

%서브 함수들.
function a=newmean(in)
%평균을 계산한다.
global n
a=sum(in)/n;

function m=newmedian(v)
%중간 값을 계산한다.
global n
w=sort(v);
if rem(n,2)==1
   m=w((n+1)/2);
else
   m=(w(n/2)+w(n/2+1))/2;
end