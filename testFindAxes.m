clc;
clear; 
close all;
clock1 = imread("images/clock1.jpg");

[p12, p6, p9, p3] = findAxes(clock1);
