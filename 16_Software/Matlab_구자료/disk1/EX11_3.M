% Effect of finite open loop gain
%
a = logspace(2,8);
r1 = 500; r2 = 50e3; r21 = r2/r1;
g = [];
n = length(a);
for i = 1:n
 g(i) = r21/(1+(1+r21)/a(i));
end
semilogx(a,g,'w')
xlabel('Open-loop gain')
ylabel('Closed-loop gain')
title('Effect of Finite Open-loop Gain')
axis([1.0e2,1.0e8,40,110])