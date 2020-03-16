clear; clc; close all;

load('cam1_1.mat')
load('cam1_2.mat')
load('cam1_3.mat')
load('cam1_4.mat')
load('cam2_1.mat')
load('cam2_2.mat')
load('cam2_3.mat')
load('cam2_4.mat')
load('cam3_1.mat')
load('cam3_2.mat')
load('cam3_3.mat')
load('cam3_4.mat')

%Grayscale and cropping
numFrames = size(vidFrames1_1,4);
frame1 = zeros(480,640,numFrames);
for j = 1:numFrames
    frame1(:,:,j) = rgb2gray(vidFrames1_1(:,:,:,j));
end
%cropped1_1 = zeros(size(frame1));
%for j = 1:numFrames
%    x = frame1(:,:,j);
%    x(1:192,:) = 0;
%    x(288:end,:) = 0;
%    cropped1_1(:,:,j) = x;
%end

%point tracker
pointTracker = vision.PointTracker; 