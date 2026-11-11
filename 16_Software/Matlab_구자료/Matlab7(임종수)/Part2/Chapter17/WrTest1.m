%
% 난수를 생성하여 serial port COM2로 송출하는 M-file..
%
% 2002, 05, 10              By Lim Jong Su
%

RandData=rand(1,500);
s=whos('RandData');						      
COM2SerialObj=serial('COM2');
set(COM2SerialObj,'outputbuffersize',s.bytes)
fopen(COM2SerialObj)
set(COM2SerialObj,'BaudRate',57600)
fwrite(COM2SerialObj,RandData,'double')			
