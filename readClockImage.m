clc; clear; close all;

I = imread('images/clock1.jpg');

[I12, I6, I10, I4, cent] = firstFrame(I);