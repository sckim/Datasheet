function z=LimDyStruct(Dy_Names, StartInd, EndInd)
%
% LimAve.m  Dynamic Field Names에 대한 예제 함수!
%
% 2007, 05, 12  By Lim Jong Su
%
for Ind=StartInd:EndInd
    z(Ind)=Dy_Names.(['Lim',num2str(Ind)])(Ind);
    Dy_Names.(['Lim',num2str(Ind)])(Ind)=1+Ind;
end