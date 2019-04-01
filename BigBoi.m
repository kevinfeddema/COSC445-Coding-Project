clc; clear; 

V = VideoReader('videos/Clock219.mp4'); 
I = read(V, 1);

images = read(V, [1 100]); 

N = V.NumberOfFrames;

[I12, I6, I10, I4] = firstFrame(I);
Inext = read(V,2);
if(size(size(Inext(3)) > 1))
Inext = rgb2gray(Inext);
end
[x12, y12,x6, y6,x10, y10,x4, y4] = SIFT(Inext, I12,I6,I10, I4);
[centerX,centerY] = findClockCenter([x12 y12],[x6 y6],[x10 y10],[x4 y4]);
E = getEdges(Inext, 0.08, 0.2, 1);
lines = getHoughLines(E);
[times] = [];

cent = [centerX, centerY];
longLines = longestEdge(lines,cent);

for k = 1:length(longLines)
   if(true)

   
   point = longLines(k, :);
   if(point == pdist([x;cent], 'euclidean'))
       point = x;
   else
       point = y;
   end
   
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

fprintf("The time is: %.0f:%.0f:%.0f", times(3)/5, times(2), times(1));






%for i = 1:10:N
%    imshow(read(V,i));
%    pause(0.2);
%end
