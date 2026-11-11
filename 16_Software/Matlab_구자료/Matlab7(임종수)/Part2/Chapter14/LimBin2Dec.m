function Result=LimBin2Dec(BinStr)
%
%이 프로그램은 2진 소수를 십진 소수로 바꾸어 주는 program이다.
%
% 2002, 4, 21       By Lim Jong Su
%

PointPos=findstr(BinStr,'.');           % 2진 소수점의 위치 추출.
Fraction=BinStr(PointPos+1:end);      % 2진 소수 부분 추출.
Count=length(Fraction);

if Count < 24
    TempFraction=(bin2dec(Fraction))/2^Count;
else
    disp('주어진 수치는 2^24보다 높은 정밀도를 요구한다.')
end;

integer=BinStr(1:PointPos-1);         % 2진 정수 부분 추출.
IntPart=bin2dec(integer);
Result=IntPart+TempFraction;