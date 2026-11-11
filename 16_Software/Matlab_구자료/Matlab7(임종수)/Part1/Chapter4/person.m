function y=person(str)
%
%1998, 12, 16  By Lim Jong Su
%

data_list=cell(5,2);

data_list{1,1}=29;				%double형 데이터 type!
data_list{1,2}='David J. Kruglinski';		%char형 데이터 type!
data_list{2,1}=32;
data_list{2,2}='Paul M. Embree';
data_list{3,1}=12;
data_list{3,2}='Rulph Chassaing';
data_list{4,1}=51;
data_list{4,2}='T. W. Parks';
data_list{5,1}=46;
data_list{5,2}='C. S. Burrus';

data_len=size(data_list,1);	%size(data_list,1)에서 "1"을 사용하면
			        %행의 길이를 돌려준다.
for index=1:data_len
   if findstr(str,lower(data_list{index,2})) 
      y=data_list{index,1}; 
      break;
   end
end