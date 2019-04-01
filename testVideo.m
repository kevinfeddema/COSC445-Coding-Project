clc;clear;close all;
    
%load the video
video = VideoReader('videos/Clock219.mp4');

%determine height and width of frames
vidHeight = video.Height;
vidWidth = video.Width;

%create a video structure array
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);

%to read the video during a specific time interval use:
%video.CurrentTime = 1; (start 1 second from the beginning of video)
%while video.CurrentTime <= 2 (run from 1 to 2 seconds)
%   readFrame(video)
%end

%read each frame into our array after running our algorithm
k = 1;
while hasFrame(video)
    
    frame = readFrame(video);
    
    %our algorithm goes here to edit each frame to indicate the time
    %before storing the updated frame with time back into the array
    
    %testing to see if editing frames works for playback
    frame = imgaussfilt(frame, 10);
    
    s(k).cdata = frame;
    
    k = k + 1;
    
end

%resize default figure and axes so they match the video width and height 
set(gcf,'position',[150 150 video.Width video.Height]);
set(gca,'units','pixels');
set(gca,'position',[0 0 video.Width video.Height]);

%play the video using the original framerate
movie(s,1,video.FrameRate);
