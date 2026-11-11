%
%PIE.M   pie chart에 변화를 준 예제 프로그램.
%
%1998.2.24      By Lime Jong_Su
%

close all
clear all

product=[19.3 22.1 51.6
         34.2 70.3 82.4
         61.4 82.9 90.8
         50.5 54.9 59.1
         29.4 36.3 47.0];

xx=sum(product);
explode=zeros(size(xx));
[c,offset]=max(xx);
explode(offset)=1;
h=pie(xx,explode);
set(gcf,'color','w')
patch_obj=findobj(h,'type','patch');
text_obj=findobj(h,'type','text');

text_pos=zeros(length(text_obj),3);
oldstr=get(text_obj,'string');
names=str2mat('A : ','B : ','C : ');
newstr=strcat(names,oldstr);
for n=1:length(text_obj)
   text_pos(n,:)=get(text_obj(n),'pos');
   set(text_obj(n),'string',newstr(n,:))
   set(patch_obj(n),'facecolor',[0 0 0]+(n-1)*0.3)
end

set(text_obj(1),'pos',text_pos(1,:)+[-.3 0 0])
set(text_obj(2),'pos',text_pos(2,:)+[-.5 .2 0])
set(text_obj(3),'pos',text_pos(3,:)+[.3 0 0])