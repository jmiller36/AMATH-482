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

numFrames1 = size(vidFrames1_2, 4);
numFrames2 = size(vidFrames2_2, 4);
numFrames3 = size(vidFrames3_2, 4);

positionTracker = vision.PointTracker;
noiseTracker = vision.PointTracker;

x1 = zeros(1,numFrames1);
y1 = zeros(1,numFrames1);
x2 = zeros(1,numFrames2);
y2 = zeros(1,numFrames2);
x3 = zeros(1,numFrames3);
y3 = zeros(1,numFrames3);

%Initializing these breaks the code for some reason
%gray1 = zeros(480,640,numFrames1);
%gray2 = zeros(480,640,numFrames2);
%gray3 = zeros(480,640,numFrames3);

for j = 1:numFrames1
    gray1(:,:,j) = rgb2gray(vidFrames1_2(:,:,:,j));
    if j == 1
        initialize(positionTracker, [323 358], gray1(:,:,1));
        initialize(noiseTracker, [44 71], gray1(:,:,1));
    end
    [points, pointValidity] = positionTracker(gray1(:,:,j));
    [perterbation, pertValidity] = noiseTracker(gray1(:,:,j));
    x1(j) = points(1);
    y1(j) = points(2);
    %x1(j) = points(1) - (perterbation(1) - 20);
    %y1(j) = points(2) - (perterbation(2) - 313);
end

for j = 1:numFrames2
    gray2(:,:,j) = rgb2gray(vidFrames2_2(:,:,:,j));
    if j == 1
        release(positionTracker);
        release(noiseTracker);
        initialize(positionTracker, [312 368], gray2(:,:,1));
        initialize(noiseTracker, [58 99], gray2(:,:,1));
    end
    [points, pointValidity] = positionTracker(gray2(:,:,j));
    [perterbation, pertValidity] = noiseTracker(gray2(:,:,j));
    %x2(j) = points(1);
    %y2(j) = points(2);
    x2(j) = points(1) - (perterbation(1) - 58);
    y2(j) = points(2) - (perterbation(2) - 175);
end

for j = 1:numFrames3
    gray3(:,:,j) = rgb2gray(vidFrames3_2(:,:,:,j));
    if j == 1
        release(positionTracker);
        release(noiseTracker);
        initialize(positionTracker, [383 271], gray3(:,:,1));
        initialize(noiseTracker, [20 20], gray3(:,:,1));
    end
    [points, pointValidity] = positionTracker(gray3(:,:,j));
    [perterbation, pertValidity] = noiseTracker(gray3(:,:,j));
    x3(j) = points(1);
    y3(j) = points(2);
    %x3(j) = points(1) - (perterbation(1) - 58);
    %y3(j) = points(2) - (perterbation(2) - 175);
end
temp = x3;
x3 = y3;
y3 = temp;

start1 = 4;
x1 = x1(start1 : start1 + 199);
y1 = y1(start1 : start1 + 199);

start2 = 8;
x2 = x2(start2 : start2 + 199);
y2 = y2(start2 : start2 + 199);

start3 = 8;
x3 = x3(start3 : start3 + 199);
y3 = y3(start3 : start3 + 199);

P = [x1;y1;x2;y2;x3;y3];
[U,S,V] = svd(P,'econ');
svs = diag(S);
e1 = svs(1) / sum(svs)
