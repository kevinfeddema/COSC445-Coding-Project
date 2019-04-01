clc;clear;close all;


clock1 = imread("images/clock1.jpg");
if(size(size(clock1(3)) > 1))
clock1 = rgb2gray(clock1);
end
clock1 = fixClockPerspective(clock1);
[twelve,six,nine,three, I12, I6, I9, I3] = findAxes(clock1);
[centerX,centerY] = findClockCenter(twelve,six,nine,three);

%clock1 = imread("images/Clock219.jpg");
%figure(), imshow(clock1);
%clock1 = fixClockPerspective(clock1);
%figure(), imshow(clock1);
%[twelve,six,nine,three, I12, I6, I10, I4] = findAxes(clock1);
%[twelveX,twelveY,sixX,sixY, tenX, tenY, fourX, fourY] = SIFT(clock1,I12, I6, I10, I4);
%[centerX,centerY] = findClockCenter([twelveX twelveY],[sixX sixY],[tenX  tenY],[fourX   fourY]);


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

E = getEdges(clock1, 0.08, 0.2, 1);
figure, imshow(E);

%E = imopen(E, strel('disk', 1));


lines = getHoughLines(E);

figure, imshow(E), hold on
max_len = 0;
plot(centerX,centerY,'x','LineWidth',2,'Color','blue');
%plot(six(1), six(2),'x','LineWidth',2,'Color','blue');
%plot(twelve(1),twelve(2) + (six(2)/2),'x','LineWidth',2,'Color','blue');
thetas = -1;
oldmax = -1;
%for k = 1:length(lines)
%    while(thetas ~= lines(k).theta)
%        thetas = lines(k).theta;
%        oldmax = -1;
%    end
%    if(pdist([lines(k).point1;lines(k).point2], 'euclidean') > oldmax)
%
%    oldmax = pdist([lines(k).point1;lines(k).point2], 'euclidean');
%    
%    end
%    
%    
%end

[times] = [];

for k = 1:length(lines)
   if(k == 3 || k == 6 || k == 7)
   xy = [lines(k).point1; lines(k).point2];
   %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   %plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   %plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   
   cent = [centerX, centerY];
   x = [xy(1,1), xy(1,2)];
   y = [xy(2,1), xy(2,2)];
   
   point = max(pdist([x;cent], 'euclidean'),pdist([y;cent], 'euclidean'));
   if(point == pdist([x;cent], 'euclidean'))
       point = x;
   else
       point = y;
   end
   
   %plot(point(1),point(2),'x','LineWidth',2,'Color','green');
   
   
   if(point(1) >= cent(1) && point(2) <= cent(2))
       
       plot(point(1),point(2),'x','LineWidth',2,'Color','red');
       
       calcedx = point(1) - cent(1);
       calcedy = cent(2) - point(2);
       angle = atan(calcedx / calcedy) * (180/ pi);
       time = (angle/360) * 60;
       
       times = [times, time];
       
       
   elseif(point(1) >= cent(1) && point(2) >= cent(2))
       
       plot(point(1),point(2),'x','LineWidth',2,'Color','green');
       
       opp = point(2) - cent(2);
       adj = point(1) - cent(1);
       angle = atan(opp / adj) * (180/ pi);
       time = (angle/360) * 60;
       
       times = [times, time + 15];
       
   elseif(point(1) <= cent(1) && point(2) >= cent(2))
       
       plot(point(1),point(2),'x','LineWidth',2,'Color','blue');
       
       opp = cent(1) - point(1);
       adj = point(2) - cent(2);
       angle = atan(opp / adj) * (180/ pi);
       time = (angle/360) * 60;
       
       times = [times, time + 30];
       
       
   else
       
       plot(point(1),point(2),'x','LineWidth',2,'Color','yellow');
       
       opp = cent(2) - point(2);
       adj = cent(1) - point(1);
       angle = atan(opp / adj) * (180/ pi);
       time = (angle/360) * 60;
       
       times = [times, time + 45];
       
       
       
   end
         

   end
   
   
end

figure, imshow(clock1);
title(sprintf("The time is: %.0f:%.0f:%.0f", times(3)/5, times(2), times(1)));
fprintf("The time is: %.0f:%.0f:%.0f", times(3)/5, times(2), times(1));




