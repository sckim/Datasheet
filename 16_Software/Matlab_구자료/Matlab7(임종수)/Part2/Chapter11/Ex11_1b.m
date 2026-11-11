clear all

x_n=2;                               % x0값을 x_n으로 표시하였다.
RepeatNum=7;                    % 반복 횟수를 나타내 주는 변수.
SolVector=zeros(7,1);          % 계산된 값들이 저장될 변수.

for index=1:RepeatNum
    x_nP1=3 - 1./x_n;
    x_n=x_nP1;
    SolVector(index)=x_nP1;
end

%%----------------     Display Part  --------------------------
for index=1:RepeatNum
    disp(['x' num2str(index) '=' num2str(SolVector(index)) 10]);
end

