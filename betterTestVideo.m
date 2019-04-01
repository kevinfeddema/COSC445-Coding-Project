clc; clear; 

V = VideoReader('videos/Clock219.mp4'); % open file
% Read a single frame by its index
I = read(V, 1); % read the first frame
I2 = read(V, inf); % read the last frame

% Read multiple frames by index
images = read(V, [1 100]); %read 6 frames from 500 to 505
imshow(images(:,:,:,1)); % display a frame

% get number of frames
N = V.NumberOfFrames;
% Display one frame every 500 frames
for i = 1:10:N
imshow(read(V,i));
pause(0.2);
end