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
    
    imshow(Im2);
    
    ISkew = Im2;
end