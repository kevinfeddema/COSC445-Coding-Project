

function [handLines, endPoints] = getHoughLines(edges)


[H, T, R] = hough(edges);

%imshow(H,[],'XData',T,'YData',R, 'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

P  = houghpeaks(H,3,'threshold',ceil(0.3*max(H(:))));

x = T(P(:,2));
y = R(P(:,1));
plot(x,y,'s','color','white');

lines = houghlines(edges,T,R,P,'FillGap',40,'MinLength',7);
%figure, imshow(edges), hold on
%max_len = 0;
%for k = 1:length(lines)
%   xy = [lines(k).point1; lines(k).point2];
%   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%
%   % Plot beginnings and ends of lines
%   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
%
%   % Determine the endpoints of the longest line segment
%   len = norm(lines(k).point1 - lines(k).point2);
%   if ( len > max_len)
%      max_len = len;
%      xy_long = xy;
%   end
%end

handLines = lines;

end