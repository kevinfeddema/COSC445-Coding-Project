clc;clear;close all;

clock1 = imread("images/clock2.jpg");
[twelve,six,nine,three] = findAxes(clock1);
Im2 = findClockCenter(clock1,twelve,three,six,nine);