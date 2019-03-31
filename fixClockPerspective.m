function ISkew = fixClockPerspective(IClock)
% fixClockPerspective - takes an image of a clock and performs a
%   perspective transform to make the clock circular
%
% USAGE: output = fixClockPerspective(input1);
% INPUT:
%   ICLOCK - an rgb image of a clock.  Clock may be viewed at an angle or
%            already straight on.  Clock must be the largest object in
%            frame
% OUTPUT:
%   ISKEW - an rgb image of the input image after a perspective transform.
%           Clock shape approximates a circle.

    bwImage = IClock;
    bwImage = imbinarize(bwImage);
    
    stats = regionprops(bwImage,'MajorAxisLength','MinorAxisLength','Centroid','Orientation');
    
    alpha = pi/180 * stats(1).Orientation;
    Q = [cos(alpha), -sin(alpha); sin(alpha), cos(alpha)];
    x0 = stats(1).Centroid.';
    a = stats(1).MajorAxisLength;
    b = stats(1).MinorAxisLength;
    S = diag([1, a/b]);
    C = Q*S*Q';
    d = (eye(2) - C)*x0;

    tform = maketform('affine', [C d; 0 0 1]');
    ISkew = imtransform(IClock, tform);
end