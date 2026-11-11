function DecNum=DBbin2dec(BinNum)
%
% Binary Number strings is converted to decimal number! 
%
% 2000, 12, 12			By Lim Jong Su
%
% Corresponding inline function : double(dec2bin(DecimalNumber, BitSize))-48.
%

len=length(BinNum);
Temp = 0;

for Ind=1:(len-1)
   Temp = BinNum(Ind)*2^(len-Ind) + Temp;
end;
DecNum=Temp+BinNum(end);