function Result=Bin2Comp(BinStr)
%
%이 프로그램은 주어진 2진 소수를 2의 보수로 바꾸어 주는 program이다.
%
% 2002, 4, 21       By Lim Jong Su
%

NonZ=strfind(BinStr,'1');					% ▶ ①
IndMax=NonZ(end);				          % ▶ ②

for Ind=1:(IndMax-1)			   	         % ▶ ③
    Temp1=~(double(BinStr(Ind))-48);
    Temp2=Temp1+48;
    BinStr(Ind)=char(Temp2);
end;

Result=BinStr;