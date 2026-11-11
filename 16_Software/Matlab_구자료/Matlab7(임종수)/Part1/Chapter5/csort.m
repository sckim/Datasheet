function d = csort(T)
%
%CSORT      벡터 T에 대한 발생 횟수와 중복이 없는 수치를 정렬하여 반환한다.
% 
% 1993.8.4     By  Paul E. Pfeiffer
% 1998.2.7     modified by Lim Jong_Su
%

T=T(:)';
P=ones(size(T));
D = [T;P];
[Y,I] = sort(T);
X = D(:,I);
m = length(T);
TI = X(1,:);
PI = X(2,:);
j = 1;
t(1) = TI(1);
p(1) = PI(1);

for i = 1:(m - 1)
if abs(TI(i) - TI(i+1)) < 1e-6    %두 원소의 차가 1e-6보다 작으면 
    j = j;			 %같다고 본다.
    p(j) =  p(j) + PI(i+1);
 else
   j = j+1;
   t(j) = TI(i+1);
   p(j) = PI(i+1);
 end
end
d = [t;p];