% polar plot of z
r = 1.2;
theta = 10*pi/180;
angle = 0:theta:36*theta;
mag = r.^(angle/theta);
polar(angle,mag)
grid
title('Polar Plot')