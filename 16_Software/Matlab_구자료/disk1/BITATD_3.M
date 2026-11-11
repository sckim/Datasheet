function Y_dig = bitatd_3(X_analog)
%
% bitatd_3 is a function program for obtaining
%         the digital value fiven an input analog
%         signal
%
% usage:  Y_dig = bitatd_3(X_analog)
%         Y_dig is the digital number
%         X_analog is the analog input
%
if X_analog < -2.5
   Y_dig = 0;
elseif X_analog >= -2.5 & X_analog < -1.5
   Y_dig = 1;
elseif X_analog >= -1.5 & X_analog < -0.5
   Y_dig = 2;
elseif X_analog >= -0.5 & X_analog < 0.5
   Y_dig = 3;
elseif X_analog >= 0.5 & X_analog < 1.5
   Y_dig = 4;
elseif X_analog >= 1.5 & X_analog < 2.5
   Y_dig = 5;
elseif X_analog >= 2.5 & X_analog < 3.5
   Y_dig = 6;
else
   Y_dig = 7;
end
Y_dig;
end

