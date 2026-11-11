%
% COM2 serial port를 통하여 유입되는 데이터를 
% COM1 serial port를 사용하여 받는다.
%
% 2002, 05, 10              By Lim Jong Su
%

x=1:10;
for Ind2=1:5
    RandData=fread(COM1SerialObj,100,'double');
    pause(0.1)							     
    %  RandData=RDat((100*Ind2-99):(100*Ind2));
    h=plot(x,RandData(1:10));
    for Ind=2:10       
        set(h,'ydata',RandData((10*Ind-9):(10*Ind)))
    end
end
fclose(COM1SerialObj)
delete(COM1SerialObj)
clear all