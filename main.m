%   Author : Wonjoong Jason Cheon
%   Date : 2017-05-15

clc
clear
close all
%% MC OUTPUT TO 2D MATRIX
folder_name = uigetdir;
% [FileName,PathName] = uigetfile('*.txt','Select the MATLAB code file');
dose_files = dir(fullfile(folder_name));
dose_files(1:2,:) = [];
dose_data_sum = load(fullfile(folder_name,dose_files(1).name));
dose_data_sum(:,3) = 0;
%
h = waitbar(0,'Please wait...');
steps = size(dose_files,1);
for iter1= 1: size(dose_files,1)
    dose_data_buffer = load(fullfile(folder_name,dose_files(iter1).name));
    dose_data_sum(:,3) = dose_data_sum(:,3) + dose_data_buffer(:,3);
    clear dose_data_buffer
    waitbar(iter1 / steps);
end
close(h) 
%
sz = sqrt(size(dose_data_sum,3));
dose_data_image = reshape(dose_data_sum(:,3),sz,sz);
figure, imshow(dose_data_image,[]), 
dose_data_image_horizontal =  dose_data_image(sz/2,:);
dose_data_image_vertical =  dose_data_image(:,sz/2);
figure, subplot(2,1,1), plot(dose_data_image_horizontal)
subplot(2,1,2), plot(dose_data_image_vertical);
%% SAVE 2D DOSE DISTRIBUTION FOR RIT
img2rit(im,(6.5/3)*8,'Homo_Scint_Recon_resize_2.mat',500)

