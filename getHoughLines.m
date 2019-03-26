

function [] = getHoughLines(edges)


[H, R, T] = hough(edges);
imshow(H,[],'XData',T,'YData',R, 'InitialMagnification','fit');








end