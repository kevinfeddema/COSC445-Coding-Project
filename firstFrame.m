function [I12, I6, I9, I3, cent] = firstFrame(img)

    clock1 = img;
    if(size(size(clock1(3)) > 1))
    clock1 = rgb2gray(clock1);
    end
    %clock1 = fixClockPerspective(clock1);
    [twelve,six,nine,three, I12, I6, I9, I3] = findAxes(clock1);
    [centerX,centerY] = findClockCenter(twelve,six,nine,three);

    figure(),imshow(clock1);
    hold on;
    plot(centerX,centerY,'r+','MarkerSize',6);

    E = getEdges(clock1, 0.08, 0.2, 1);
    figure, imshow(E);

    lines = getHoughLines(E);

    figure, imshow(E), hold on
    max_len = 0;
    plot(centerX,centerY,'x','LineWidth',2,'Color','blue');
    %plot(six(1), six(2),'x','LineWidth',2,'Color','blue');
    %plot(twelve(1),twelve(2) + (six(2)/2),'x','LineWidth',2,'Color','blue');
    thetas = -1;
    oldmax = -1;

    [times] = [];

    cent = [centerX, centerY];
    longLines = longestEdge(lines,cent);
    
    
    
    for k = 1:length(longLines)
       point = longLines(k, :);
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

    
    imshow(img);
    hold on;
    %plot(cent(1),cent(2),'x','LineWidth',2,'Color','blue');
    title(sprintf("The time is: %.0f:%.0f:%.0f", times(3)/5, times(2), times(1)));

end