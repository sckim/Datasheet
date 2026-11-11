function y=average(x)
% AVERAGE   Mean of vector elements.
%
% average(x)는 벡터 x의 평균을 반환하며, 만일, 입력이 없으면 error를 내보낸다.
%
% 2001, 9, 11     By Lim Jon_Su
%
m=length(x);

if (~m)        % nonzero(즉, True)에 대한 부정은 zero(즉, False)가 된다.
   error('입력은 값이 있는 벡터여야 한다.');
end

y=sum(x)/length(x);  % 실제, 계산하는 부분!