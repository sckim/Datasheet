function QORoundMTest
% Quantizer Object : RoundMode Comparing Plot
% 
%   2007, 05, 2         By Lim Jong Su
%
q=quantizer([8 2]);
QE=eps(q);
PQRange=[0:QE/4:QE 2*QE];
x=1:length(PQRange);

q.RoundMode='ceil';
RoundModeComp(x,q,PQRange,1)
q.RoundMode='convergent';
RoundModeComp(x,q,PQRange,2)
q.RoundMode='fix';
RoundModeComp(x,q,PQRange,3)
q.RoundMode='floor';
RoundModeComp(x,q,PQRange,4)
q.RoundMode='nearest';
RoundModeComp(x,q,PQRange,5)
legend('Quantized Data','Original Data', ...
    'Location',[0.6202 0.1437 0.2643 0.1]);

function RoundModeComp(x,q, PQRange, PlotNum)
Py=quantize(q,PQRange);
subplot(3,2,PlotNum)
stem(x,Py)
hold on
stem(x,PQRange,'r','filled')
set(gca,'xtick',1:6,'xtickLabel',{'0' 'QE/4' 'QE/2' '3QE/4' 'QE' '2QE'})
set(gcf,'color','w')
grid on
title(tostring(q))