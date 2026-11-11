function vsq2 = voltage2(t)
% voltage2  This function is used to
%           define the voltage waveform

x = 0:0.1:6;
n = length(x);
   for t = 1:n
      it = 0.1*t;
    if it <= 2.0
      vsq2(t) = 4.0^2;
    else
      vsq2(t) = 0.0;
    end
   end
end
