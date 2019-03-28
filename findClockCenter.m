function [centerX,centerY] = findClockCenter(twelve,six,nine,three)
    verticalAxis = polyfit([twelve(1), six(1)],[twelve(2),six(2)],1);
    horizontalAxis = polyfit([nine(1),three(1)],[nine(2),three(2)],1);
    
    m1 = verticalAxis(1);
    m2 = horizontalAxis(1);
    b1 = verticalAxis(2);
    b2 = horizontalAxis(2);
        
%     if m1 == 0
%         m1 = .0001;
%     end
%     if m2 == 0
%         m2 = .0001;
%     end

    centerX = (b2 - b1) / (m1 - m2);
    centerY = (m1.*b2 - m2.*b1) / (m1 - m2);

end