function [ snr ] = snr(pic_real, pic_morp )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%assumption
%pic_real = signal+noise
%pic_morp = signal+noise+noise_from_interpolation

%nan values are at sameplace both pictures
C=pic_real+pic_morp;
pic_real = C - pic_morp;
pic_morp = C - pic_real;
mean_ = mean(pic_morp(isfinite(pic_morp(:)))-pic_real(isfinite(pic_real(:))))
std_ = std(pic_morp(isfinite(pic_morp(:)))-pic_real(isfinite(pic_real(:))))
%convert  from decibels to non-desibel values
pic_real = 10.^(pic_real./10);
pic_morp = 10.^(pic_morp./10);

%noise from interpolation
noise = pic_morp-pic_real;

noise = noise(isfinite(noise(:)));
real = pic_real(isfinite(pic_real(:)));

%result
snr  = sum(noise.*noise)./sum(real.*real);
std_ = std(noise)
mean_ = mean(noise)

end

