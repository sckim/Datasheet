function pm_cb(x)
% 짝,홀수를 판별하는 M-file.
%
% 1998.2.4      By Lim Jong_Su

if x ~=abs(x)
   msgbox('입력 값은 양의 실수이어야 한다.','에러','error');
   return;
%   error('입력 값은 양의 실수이어야 한다.');  
elseif x ~= fix(x)
   msgbox('정수가 아니다.','에러','error');
   return;
end

y=rem(x,2); 

switch 
ycase 0
   disp('입력 값은 짝수!');
otherwise
   disp('입력 값은 홀수!');
end