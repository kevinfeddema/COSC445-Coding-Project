

E = imread("images/clock1.jpg");
E = rgb2gray(E);
E = edge(E, 'Canny');

getHoughLines(E);

