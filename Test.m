clc;clear;close all;

clock1 = imread("images/Clock219.jpg");
figure(), imshow(clock1);
%clock1 = fixClockPerspective(clock1);
%figure(), imshow(clock1);
[twelve,six,nine,three, I12, I6, I10, I4] = findAxes(clock1);
[twelveX,twelveY,sixX,sixY, tenX, tenY, fourX, fourY] = SIFT(clock1,I12, I6, I10, I4);
[centerX,centerY] = findClockCenter([twelveX twelveY],[sixX sixY],[tenX  tenY],[fourX   fourY]);

% low_thresh = 0.08; 
% high_thresh = 0.2; 
% sigma = 1;
% 
% %edges = getEdges(clock1,low_thresh,high_thresh,sigma);
% edges = rgb2gray(clock1);
% edges = edge(edges, 'Canny');
% getHoughLines(edges);

figure(),imshow(clock1);
hold on;
plot(centerX,centerY,'r+','MarkerSize',6);

