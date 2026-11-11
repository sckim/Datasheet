function z=CCode(msg,states)
%
%Generator Matrix를 이용한 Convolutional Encoder.
%반드시, Adder와 Shift Register간의 연결 상태는 행 방향으로
%작성해 주어야 한다.
%
%1999. 7. 21 	By Lim Jong Su
%

[a,b]=size(states);
R=input(['Modulo-2의 개수는 ' num2str(a) '입니까?'],'s');

if upper(R) == 'Y'
   y=states(:);
   DataBitNum=length(msg);
   tempG=zeros(DataBitNum,(DataBitNum-1)*2+length(y));
   
   for index=1:DataBitNum
      tempG(index,(1:length(y))+a*(index-1))=y';
   end
   z=mod(msg*tempG,2);
else
   z='invalid!';
   return;
end
