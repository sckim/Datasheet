function RegNResult=RegressN(LabData, RegOrder)
%
% Simple Linear Regression Model.
%-> Least Squares Estimator alpha and beta return.
%
% 매개변수 설명 :
% 1) LabData : Observed Data Set
%-> LabData must be 2 column Data!
% 2) RegOrder : 원하는 다항식의 차수.
%
% 2002, 01, 05              By Lim Jong Su
%

if size(LabData,2) ~= 2
    error('LabData must be 2 column Data!');
end

XData=LabData(:,1);
n=length(XData);

%Matrix F를 만든다.
F=zeros(n,RegOrder+1);
for index=1:(RegOrder+1)
    F(:,index)=XData.^(index-1);
end

YData=LabData(:,2);

% F'FC=F'Y   ->  C=(F'F)\(F'Y)    
RegNResult=(F'*F)\(F'*YData);
