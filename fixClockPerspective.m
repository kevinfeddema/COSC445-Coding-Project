function ISkew = fixClockPerspective(IClock)
    bwImage = rgb2gray(IClock);
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
    Im2 = imtransform(IClock, tform);
    
    bwCircle = rgb2gray(Im2);
    bwCircle = imbinarize(bwCircle);
    centerPoint = regionprops(bwCircle,'Centroid');
    
    imshow(Im2);
    plot(centerPoint(1).Centroid(1), centerPoint(1).Centroid(2), 'r+', 'MarkerSize', 10);
    
    ISkew = Im2;
end