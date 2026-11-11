function [f,x] = errpdf(q,x)
%ERRPDF Probability density function of the quantization error
% [F,X]=ERRPDF(Q) returns the probability density function F evaluated
% at the values in X of a uniformly distributed random quantization 
% error that would arise from quantizing a signal by quantizer Q.
%
%   F = ERRPDF(Q,X) returns the probability density function F evaluated 
%  at the values in vector X.
%
  
e = double(eps(q));
if nargin<2, x=[]; end
if isempty(x), x = linspace(-2*e,2*e,128); end

switch q.roundmode
  case 'fix'
    f = (-e<x & x<e)/(2*e);
  case 'floor'
    f = (-e<x & x<=0)/e;
  case 'ceil'
    f = (0<=x & x<e)/e;
  case 'convergent'
    f = (-e/2<=x & x<=e/2)/e;
  case 'nearest' 
    f = (-e/2<x & x<=e/2)/e;
  case 'round'
    f = (-e/2<=x & x<=e/2)/e;
  otherwise
    error('Unrecognized roundmode.')
end