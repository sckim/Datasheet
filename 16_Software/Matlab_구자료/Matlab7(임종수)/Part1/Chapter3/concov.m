function [con_mat,cov_mat]=concov(x,y,p)
%
% CONCOV   컨버루션 행렬과 공분산을 구하는 함수.
%
% 1998.1.30   By Lim Jong_Su
%

if (nargin==3) & (nargout==1)
   con_mat=convm(x,p);
elseif  (nargin==3) & (nargout==2) 
   con_mat=convm(x,p);
   cov_mat=covariance(x,y);
else
   error('입,출력 매개변수의 갯 수가 맞지 않음!');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%서브 함수들 :
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y=convm(x,p)
%
% CONVM   컨버루션 행렬을 구하는 함수.
% 1998.1.30   By Lim Jong_Su
%
N=length(x);
index=N+2*p-1;
y=zeros(N+p-1,p);
x=x(:);
xpad=[zeros(p-1,1);x;zeros(p-1,1)];
for i=1:p
   y(:,i)=xpad(p-i+1:index-i);
end
y=y';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z=covariance(x,y)
%
% COVARIANCE   주어진 두 벡터의 공분산을 구하는 함수.
%
% 1998.1.30   By Lim Jong_Su
%

if length(x) ~= length(y)
   error('입력 벡터들의 크기는 같아야 한다.');
end
x=[x(:) y(:)];				%어떠한 크기를 갖는 배열 X일지라도
					%X(:)를 하면 하나의 열 벡터로 바뀐다.
[n,p]=size(x);

x=x-repmat(sum(x)/n,n,1);   %"repmat.m"함수에 대해서는 뒤에서 설명 할 것이다
z=x'*x/(n-1);