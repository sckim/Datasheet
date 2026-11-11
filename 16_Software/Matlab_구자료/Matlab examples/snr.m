function [out] = snr(in1, in2)
%
%  Calculate Signal to noise ratio
%  SNR = snr(x, x_hat)
%
%  in1 : original image
%  in2 : noised image
%
err =  double(in2) - double(in1);
estimated = double(in2);

num = var(err(:))
denum = var(estimated(:))

out = 20*log10(num/denum);