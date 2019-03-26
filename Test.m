clc;clear;close all;

clock1 = imread("images/clock2.jpg");
[twelve,six,nine,three, I12, I6, I9, I3] = findAxes(clock1);
Im2 = findClockCenter(clock1,twelve,three,six,nine);
imshow(Im2);
