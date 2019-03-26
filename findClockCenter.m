function ISkew = findClockCenter(IClock,twelve,three,six,nine)
    inputPoints = [twelve,three,six,nine];
    inputX = transpose(inputPoints([1 3 5 7]));
    inputY = transpose(inputPoints([2 4 6 8]));
%     M = [inputX.^2, inputX.*inputY, inputY.^2,inputX,inputY, -ones(size(inputX,1),1)];
%     [U,S,V] = svd(M,0);
%     ABCDEF = V(:,end);
%     
%     if size(ABCDEF,2) > 1
%         error 'Data cannot be fit with unique ellipse'
%     else
%         ABCDEF = num2cell(ABCDEF);
%     end
%     [A,B,C,D,E,F] = deal(ABCDEF{:});
%     Q = [A,B/2;B/2 C];
%     x0 = -Q\[D;E]/2;
%     dd = F + x0'*Q*x0;
%     Q = Q/dd;
%     [R, eigen]=eig(Q);
%     eigen=eigen([1,4]);
%     if ~all(eigen>=0),error 'Fit produced a non-elliptic conic section';end
%     idx = eigen>0;
%     eigen(idx)=1./eigen(idx);
%     AxesDiams = 2*sqrt(eigen);
%     theta=atand(tand(-atan2(R(1),R(2))*180/pi));
%     report.Q=Q;
%     report.d=x0(:).';
%     report.ABCDE=[A, B, C, D, E]/F;
%     report.AxesDiams=sort(AxesDiams(:)).';
%     report.theta=theta;
    paddedImage = imresize(IClock,[size(IClock,1)+100,size(IClock,2)+100]);
    paddedImage = padarray(paddedImage,[50 50]);
    bwImage = rgb2gray(paddedImage);
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
    Im2 = imtransform(paddedImage, tform);
    imshow(Im2)
    
    ISkew = Im2;
end