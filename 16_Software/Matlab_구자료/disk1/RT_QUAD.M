function rt = rt_quad(coef)
%
% rt_quad  is a function for obtaining the roots of 
%             of a quadratic equation
%
% usage: rt = rt_quad(coef)
%             coef is the coefficients a,b,c of the quadratic
%                  equation ax*x + bx + c =0
%             rt are the roots, vector of length 2
%
% coefficient a, b, c are obtained from vector coef
a = coef(1);
b = coef(2);
c = coef(3);
int = b^2 - 4*a*c;
if int > 0
   srint = sqrt(int);
   x1= (-b + srint)/(2*a);
   x2= (-b - srint)/(2*a);
elseif int == 0
   x1= -b/(2*a);
   x2= x1;
elseif int < 0
   srint = sqrt(-int);
   p1 = -b/(2*a);
   p2 = srint/(2*a);
   x1 = p1+p2*j;
   x2 = p1-p2*j;
end
rt =[x1;
     x2];
end