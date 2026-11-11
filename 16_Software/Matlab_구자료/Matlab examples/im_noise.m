function [out_image] = im_noise(origin_image, SNR);
%
%  Generate gaussian random noise
% [output image] = run_noise(original image, SNR)
%
% original_image : source image
% SNR : signal to noise ration
%
[y_size x_size]=size(origin_image);
x_variance = var(double(origin_image(:)));

% calculate noise variance due to SNR
noise_variance = x_variance*(10^(-SNR/20));

% generate gaussian distribution noise image with noise variance
noise_source = sqrt(noise_variance)*randn(size(origin_image));
%noise_source = max(0,min(noise_source,1)); % Truncate if necessary

out_image = noise_source + double(origin_image);
out_image = max(0,min(out_image,255)); % Truncate if necessary
out_image = uint8(round(out_image));

subplot(1,2,1);
imshow(origin_image);
subplot(1,2,2);
imshow(out_image);