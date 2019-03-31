

E = imread("images/clock1.jpg");
E = rgb2gray(E);
%imshow(E);
%E = imopen(E, strel('disk', 5));
%figure,imshow(E);
E = getEdges(E, 0.08, 0.2, 1);
imshow(E);

figure, imshow(E);
%getHoughLines(E);

