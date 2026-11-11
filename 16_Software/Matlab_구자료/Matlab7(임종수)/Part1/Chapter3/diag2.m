function [v,d]=diag2(x)

%
% Chapter 3. 연습문제 7에 대한 M-file.
%
% 2002, 6, 9            By Lim Jong Su
%

[r,c]=size(x);
for k=1:r
    v(k)=x(k,k);
end

for n=1:r
    for m=1:c
        if n==m
            d(n,m)=v(n);
        else
            d(n,m)=0;
        end
    end
end