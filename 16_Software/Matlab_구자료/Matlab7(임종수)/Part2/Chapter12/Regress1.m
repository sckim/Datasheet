function RegResult=Regress1(LabData)
%
% Simple Linear Regression Model.
%-> Least Squares Estimator alpha and beta return.
%
% 매개변수 설명 :
% 1) LabData : Observed Data Set
%-> LabData must be 2 column Data!
%
% 2002, 01, 05              By Lim Jong Su
%

if size(LabData,2) ~= 2
    error('LabData must be 2 column Data!');
end

XData=LabData(:,1);
n=length(XData);
Averagex=(1/n)*(sum(XData));            % XData 평균.
XDeviation=XData-Averagex;             % XData 편차.
Sxx=(1/n)*(sum(XDeviation.^2));           % XData 분산.
YData=LabData(:,2);
n=length(YData);
Averagey=(1/n)*(sum(YData));             % YData 평균.
YDeviation=YData-Averagey;              % YData 편차.
% X, YData의 공분산.
Sxy=(1/n) *sum(XData.*YData) - Averagex * Averagey;

beta=Sxy/Sxx;
alpha=Averagey - beta * Averagex;

RegResult=[alpha beta];
