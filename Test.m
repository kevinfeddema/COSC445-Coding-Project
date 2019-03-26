clc;clear;close all;

clock1 = imread("images/clock2.jpg");
<<<<<<< HEAD
[twelve,six,nine,three, I12, I6, I9, I3] = findAxes(clock1);
Im2 = findClockCenter(clock1,twelve,three,six,nine);
imshow(Im2);
=======
Im2 = findClockCenter(clock1);
[twelve,six,nine,three] = findAxes(Im2);
>>>>>>> 86db34e674aa80bbba16cd025499098f9f109147
