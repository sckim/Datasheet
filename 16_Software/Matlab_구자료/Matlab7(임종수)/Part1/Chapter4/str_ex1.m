function man=str_ex1 
%
%str_ex1.m  struct array man을 생성해주는 함수!
%field names : name, height,sight]
%
%1998, 12, 30  By Lim Jong Su
%

total=3;
%cell array preallocation.
str_name=cell(3,1);
val_height=cell(3,1);
val_sight=cell(3,1);

%Data Insertion.
name=str2mat('lim jong su','lee do hyun','lee gi jung');
height=[183;180;176];
sight=[0.5 0.7; 1.5 1.2; 1.0 1.2];

%Using Comma-Separated List method.
%struct array man의 field들을 생성!
[str_name{:}]=deal(name(1,:),name(2,:),name(3,:));	
[val_height{:}]=deal(height(1),height(2),height(3));
[val_sight{:}]=deal(sight(1,:),sight(2,:),sight(3,:));
%struct array man의 생성!
man=struct('name',str_name,'height',val_height,'sight',val_sight);