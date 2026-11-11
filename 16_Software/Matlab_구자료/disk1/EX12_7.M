%
% Analysis of MOSFET bias circuit
%
diary ex12_7.dat
diary on
vt=2; kn=0.5e-3; vdd=9;
rg1=10e6; rg2=10e6; rs=10e3; rd=10e3;
vg=vdd * rg2/(rg1 + rg2);

% Id is calculated asssuming device is in saturation

a1=kn*(rd^2);
a2=-(1 + 2*(vg - vt)*rd * kn);
a3=kn * (vg - vt)^2;
p1=[a1,a2,a3];
r1=roots(p1);

% check for the sensible value of the drain current
 
vgs = vg - rs * r1(1);
 if vgs > vt
	id = r1(1);
   else
	id = r1(2);
 end
vgs = vg - id*rs;
vds = vdd - (rs + rd)*id;

% Confirm that device is in saturation

 if vds < vgs-vt
   b1=(rs + rd)^2 + 2*rd*(rd + rs);
   b2 = 2*vdd*(rd + rs) - 2*vdd*rd ...
       -2*(vg - vt)*(rd + rs) - 1/kn;
   b3 = 2*(vg - vt)*vdd - vdd^2;
   p2 = [b1,b2,b3];
   r2=roots(p2);

% check for sensible value of the drain current

   vgs = vg - rs*r2(1);
	if vgs > vt
	  id = r2(1);
	 else
	  id=r2(2);
	end
vds=vdd - (rs + rd)*id;
end

% print out results
fprintf('Drain current is %7.3e Amperes\n',id)
fprintf('Drain-source voltage is %7.3e Volts\n', vds)



 