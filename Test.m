clc;clear;close all;

clock1 = imread("images/clock2.jpg");
clock1 = fixClockPerspective(clock1);
[twelve,six,nine,three, I12, I6, I9, I3] = findAxes(clock1);
[centerX,centerY] = findClockCenter(twelve,six,nine,three);



imshow(clock1);

