function Result=LimDec2Bin(FloatDec)
%
%이 프로그램은 십진 소수를 2진 소수로 바꾸어 주는 program이다.
%
% 2002, 4, 21       By Lim Jong Su
%

IntPart=fix(FloatDec);                        % 정수부분 추출.
TempFraction=FloatDec-IntPart;              % 소수부분 추출.

Count=0;
while(TempFraction ~= fix(TempFraction))
    Temp=TempFraction*2;
    Count=Count+1;
    if Count == 24
        TempFraction=Temp;
        disp('주어진 수치는 2^24보다 높은 정밀도를 요구한다.')
        break;
    end;
    TempFraction=Temp;
end;
Fraction=dec2bin(TempFraction,Count);
PointPos=Count;
Integer=dec2bin(IntPart);
Result=[Integer char(46) Fraction];