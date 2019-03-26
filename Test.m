clc;clear;close all;

clock1 = imread("images/clock2.jpg");
Im2 = findClockCenter(clock1);
[twelve,six,nine,three] = findAxes(Im2);
