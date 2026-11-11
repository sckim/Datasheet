function RandData=RdSub(In)

if In==0
    COM1SerialObj=serial('COM1');
    set(COM1SerialObj,'inputbuffersize',8*200);
    fopen(COM1SerialObj)
    set(COM1SerialObj,'BaudRate',57600)
    RandData=fread(COM1SerialObj,100,'double')
else
    RandData=fread(COM1SerialObj,100,'double')
end
