function [p12, p6, p9, p3, I12, I6, I9, I3] = findAxes(clock1)

if(size(size(clock1(3)) > 1))
clock1 = rgb2gray(clock1);
end
imshow(clock1);

rect12 = getrect();
rect6 = getrect();
rect9 = getrect();
rect3 = getrect();


p12 = [rect12(1) + rect12(3)*(1/2), rect12(2) + rect12(4) * (1/2)];

p6 = [rect6(1) + rect6(3)*(1/2), rect6(2) + rect6(4) * (1/2)];
p9 = [rect9(1) + rect9(3)*(1/2), rect9(2) + rect9(4) * (1/2)];
p3 = [rect3(1) + rect3(3)*(1/2), rect3(2) + rect3(4) * (1/2)];

hold on;
plot(p12(1), p12(2), 'r+', 'MarkerSize', 10);

plot(p6(1), p6(2), 'r+', 'MarkerSize', 10);
plot(p9(1), p9(2), 'r+', 'MarkerSize', 10);
plot(p3(1), p3(2), 'r+', 'MarkerSize', 10);
%I12 = clock1(rect12(1):rect12(3), rect12(2):rect12(4));
I12 = clock1(uint16(rect12(2)):uint16(rect12(2)) + uint16(rect12(4)),uint16(rect12(1)):(uint16(rect12(1)) + (uint16(rect12(3)))));
%figure, imshow(I12);
I6 = clock1(uint16(rect6(2)):uint16(rect6(2)) + uint16(rect6(4)),uint16(rect6(1)):(uint16(rect6(1)) + (uint16(rect6(3)))));
%figure, imshow(I6);
I9 = clock1(uint16(rect9(2)):uint16(rect9(2)) + uint16(rect9(4)),uint16(rect9(1)):(uint16(rect9(1)) + (uint16(rect9(3)))));
%figure, imshow(I9);
I3 = clock1(uint16(rect3(2)):uint16(rect3(2)) + uint16(rect3(4)),uint16(rect3(1)):(uint16(rect3(1)) + (uint16(rect3(3)))));
%figure, imshow(I3);

end

