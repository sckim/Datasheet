function [Encoding_Message, R_x]=crc_encoding(m_vector,g_vector)
%
% 1999, 11, 17		By Lim Jong Su
%

len_m_vector=length(m_vector);
len_g_vector=length(g_vector);

init_Reg=zeros(1,len_g_vector-1);
output=zeros(1,len_m_vector-len_g_vector);
shift_Reg=init_Reg;
temp_Reg=zeros(1,length(shift_Reg));

Tx_vector=[zeros(1,len_g_vector-1) m_vector];
shift_Num=length(Tx_vector);

temp_FF=0;

for (index=1:shift_Num)
   shift_Reg=[Tx_vector(shift_Num+1-index) shift_Reg(1:(end-1))];
   shift_Reg=sel_xor(shift_Reg,temp_Reg,g_vector);

   temp_FF=shift_Reg(end);
   temp_Reg(:)=temp_FF;   
end

R_x=shift_Reg;
Encoding_Message=[R_x m_vector];

%%%%%%%%%%%%%%%  Sub_Function %%%%%%%%%%%%%%%%
function y=sel_xor(a,b,sel_data)

temp=sel_data(1:(end-1));
pos=find(temp);
len_data=length(pos);
y=a;

for (index=1:len_data)
   y(pos(index))=xor(a(pos(index)),b(pos(index)));   
end;
