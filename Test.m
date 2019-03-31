clc;clear;close all;

clock1 = imread("images/clock1.jpg");
if(size(size(clock1(3)) > 1))
clock1 = rgb2gray(clock1);
end
clock1 = fixClockPerspective(clock1);
[twelve,six,nine,three, I12, I6, I9, I3] = findAxes(clock1);
[centerX,centerY] = findClockCenter(twelve,six,nine,three);



imshow(clock1);

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


for k = 1:length(lines)
   if(k == 3 || k == 6 || k == 7)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   
   %thetas = lines(k).theta;
   a = [centerX, centerY];
   b = twelve;
   x = [xy(1,1), xy(1,2)];
   y = [xy(2,1) , xy(2,2)];
   
   diff = (atan((y(2)-y(1))/(x(2)-x(1))) - atan((b(2)-b(1))/(a(2)-a(1)))) * 180/pi;
   fprintf("%f", diff)
    
   
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
   end
end


