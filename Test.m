clc;clear;close all;

clock1 = imread("images/clock2.jpg");
clock1 = fixClockPerspective(clock1);
[twelve,six,nine,three, I12, I6, I9, I3] = findAxes(clock1);
[centerX,centerY] = findClockCenter(twelve,six,nine,three);

low_thresh = 0.08; 
high_thresh = 0.2; 
sigma = 1;

%edges = getEdges(clock1,low_thresh,high_thresh,sigma);
edges = rgb2gray(clock1);
edges = edge(edges, 'Canny');
getHoughLines(edges);

imshow(clock1);

