function [out] = view_snr(x, noised_y)
%
%
a=double(noised_y);
b=double(x);

temp=sum(sum(a.^2))/sum(sum((a-b).^2));
out = 10*log10(temp)