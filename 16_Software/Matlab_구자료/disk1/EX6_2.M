diary ex6_2.dat
% This program computes the nodal voltage v3 of circuit
% figure 6.2
% Y is the admittance matrix
% I is the current matrix 
% V is the voltage vector

Y = [0.05-0.0225*j   0.025*j   -0.0025*j;
     0.025*j     0.01-0.0375*j   0.0125*j;
     -0.0025*j    0.0125*j   0.02-0.01*j];
 
c1 = 0.4*exp(pi*15*j/180);
I = [c1 0 0]';  % current vector entered as column vector
V = inv(Y)*I;  % solve for nodal voltages
v3_abs = abs(V(3)); 
v3_ang = angle(V(3))*180/pi;

fprintf('voltage V3, magnitude: %f \n voltage V3, angle in degree: %f', v3_abs, v3_ang)
diary