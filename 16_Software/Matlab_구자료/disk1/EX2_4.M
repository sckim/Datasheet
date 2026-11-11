%
%

[xgrid,ygrid] = meshdom(-10:1:10, -10:1:10)
z=xgrid^2+4*ygrid*xgrid+ygrid^2;
subplot(221),mesh(z),title('3-D with default viewpoint')
view = [-60,45];
subplot(222),mesh(z,view),title('3-D with azimuth -60,elevation 45')
subplot(223),contour(z,5),title('contour plot with 5 contour lines')
v = [1 3 5 7];
subplot(224), contour(z,v),title('contours at z=1,3,5,7')
