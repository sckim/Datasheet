function POut=PCheck(PIn,Parity_Type)

%
% 입력 PIn에 대한 Parity Check Function.
% 오류가 없는 경우 : 1
% 오류가 있는 경우 : 0 을 돌려준다.
% 
% 2002, 5, 20               By Lim Jong Su

P_str=lower(Parity_Type);

Len=length(PIn);
Temp=PIn(1);
for Ind=2:Len
    Temp=xor(PIn(Ind),Temp);
end
    
if strcmp(P_str,'even')
    if Temp == 0
        POut = 1;
    else
        POut = 0; 
    end
elseif strcmp(P_str,'odd')
    if Temp == 1
        POut = 1;
    else
        POut = 0; 
    end
else
    disp('Parity Type is Wrong!');
end
