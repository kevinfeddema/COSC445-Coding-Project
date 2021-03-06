function [centerX,centerY] = findClockCenter(twelve,six,nine,three)
% findClockCenter - Takes 4 points and returns the intersect.
%   Meant to find the center of a clock given the four
%   major points along the perimeter.
% 
% NOTE: Input order follows axes and not clockwise direction
% 
% USAGE: [centerX,centerY] = findClockCenter(twelve,six,nine,three);
% INPUTS:
%   TWELVE - The [m,n] coordinates of the 1st point (Twelve on a clock)
%   SIX - The [m,n] coordinates of the 2nd point (Six on a clock)
%   NINE - The [m,n] coordinates of the 3rd point (Nine on a clock)
%   THREE - The [m,n] coordinates of the 4th point (Three on a clock)
% OUTPUTS:
%   CENTER_X - The N coordinate of the intersect between the points
%   CENTER_Y - The M coordinate of the intersect between the points

    verticalAxis = polyfit([twelve(1), six(1)],[twelve(2),six(2)],1);
    horizontalAxis = polyfit([nine(1),three(1)],[nine(2),three(2)],1);
    
    m1 = verticalAxis(1);
    m2 = horizontalAxis(1);
    b1 = verticalAxis(2);
    b2 = horizontalAxis(2);
    
    %Ensure that both lines are not vertical
    if m1 == 0
        m1 = .0001;
    end
    if m2 == 0
        m2 = .0001;
    end

    centerX = (b2 - b1) / (m1 - m2);
    centerY = (m1.*b2 - m2.*b1) / (m1 - m2);

end