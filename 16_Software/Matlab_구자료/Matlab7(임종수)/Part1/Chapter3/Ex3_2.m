function Ex3_2(x)
%
% Ex3_2(x)   짝·홀수를 판별하는 M-file.
%
% 1997.1.25      By Lim Jong_Su
%

if x ~=abs(x)
   error('입력 값이 실수가 아니다');
elseif x ~= fix(x)
   error('정수가 아니다.');
elseif x <0
   error('양수여야 한다.');
end

y=rem(x,2); 

switch y
case 0
   disp('입력 값은 짝수!');
otherwise
   disp('입력 값은 홀수!');
end
