function PascalRes=PascalM(n)
%
% Pascal의 관계식.
%
% 매개변수 설명 :
% 1) n : (a+b)^n에서 n을 의미.
%
% 2002, 01, 13              By Lim Jong Su
%

PascalRes=zeros(1,n+1);     % 출력 변수에 대한 공간을 미리 할당.
for index=0:n
    PascalRes(index+1)=combination(n,index);
end;

%%--------------  SubFunction  ----------------------------
% Combination을 구해주는 함수.
function z=combination(n,r)
if (r=0) | (r=n)
    z=1;
else
    z=FactM(n)/(FactM(r)*FactM(n-r)); 
end;
% Factorial을 계산해주는 함수.
function z=FactM(n);
z=prod(1:n);