% I-V characteristics of mosfet
%
kn=1e-3; vt=1.5;
vds=0:0.5:12;
vgs=4:2:8;
m=length(vds);
n=length(vgs);

for i=1:n
	for j=1:m
	   if vgs(i) < vt
		cur(i,j)=0;
	   elseif vds(j) >= (vgs(i) - vt)
		cur(i,j)=kn * (vgs(i) - vt)^2;
	   elseif vds(j) < (vgs(i) - vt)
		cur(i,j)= kn*(2*(vgs(i)-vt)*vds(j) - vds(j)^2);
	   end
        end
end
plot(vds,cur(1,:),'w',vds,cur(2,:),'w',vds,cur(3,:),'w')
xlabel('Vds, V')
ylabel('Drain Current,A') 
title('I-V Characteristics of a MOSFET')
text(6, 0.009, 'Vgs = 4 V')
text(6, 0.023, 'Vgs = 6 V')
text(6, 0.045, 'Vgs = 8 V')
