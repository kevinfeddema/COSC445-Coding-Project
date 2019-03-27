IClock = imread('images/clock1.jpg');
IEdge = clockCanny(IClock, 0.08, 0.2, 1);
figure, imshow(IEdge);
title("Clock Edges");

function IEdge = clockCanny(ISkew, low_thresh, high_thresh, sigma)

    %STEP 1: Smooth image using gaussian filter
    ISkew = rgb2gray(ISkew);
    I_smooth = imgaussfilt(ISkew, sigma);

    %STEP 2: Compute the gradient magnitude and angle

    %filters for horizontal and vertical direction
    wx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
    wy = [1, 2, 1; 0, 0, 0; -1, -2, -1];

    %apply filters
    filter_x = conv2(I_smooth, wx, 'same');
    filter_y = conv2(I_smooth, wy, 'same');

    %calculate gradient magnitude
    magnitude = sqrt((filter_x.^2) + (filter_y.^2));

    %calculate gradient direction
    direction = atan2(filter_y, filter_x);
    direction = direction*180/pi;

    s1 = size(I_smooth, 1);
    s2 = size(I_smooth, 2);

    %make all directions positive
    for i = 1:s1
        for j = 1:s2
            if (direction(i,j) < 0) 
                direction(i,j) = direction(i,j) + 180;
            end
        end
    end

    direction4 = zeros(s1, s2);

    %adjust to only 4 directions (0, 45, 90, 135)
    for i = 1:s1
        for j = 1:s2
            if ((direction(i, j) >= 0 ) && (direction(i, j) < 22.5) || (direction(i, j) >= 157.5) && (direction(i, j) < 202.5) || (direction(i, j) >= 337.5) && (direction(i, j) <= 360))
                direction4(i, j) = 0;
            elseif ((direction(i, j) >= 22.5) && (direction(i, j) < 67.5) || (direction(i, j) >= 202.5) && (direction(i, j) < 247.5))
                direction4(i, j) = 45;
            elseif ((direction(i, j) >= 67.5 && direction(i, j) < 112.5) || (direction(i, j) >= 247.5 && direction(i, j) < 292.5))
                direction4(i, j) = 90;
            elseif ((direction(i, j) >= 112.5 && direction(i, j) < 157.5) || (direction(i, j) >= 292.5 && direction(i, j) < 337.5))
                direction4(i, j) = 135;
            end
        end
    end

    BW = zeros(s1, s2);

    %STEP 3: Apply Nonmaxima Suppression
    for i = 2:s1-1
        for j = 2:s2-1
            if (direction4(i,j) == 0)
                BW(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i,j+1), magnitude(i,j-1)]));
            elseif (direction4(i,j) == 45)
                BW(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j-1), magnitude(i-1,j+1)]));
            elseif (direction4(i,j) == 90)
                BW(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j), magnitude(i-1,j)]));
            elseif (direction4(i,j) == 135)
                BW(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j+1), magnitude(i-1,j-1)]));
            end
        end
    end

    BW = BW.*magnitude;

    %STEP 4: Double Thresholding and Connectivity Analysis using 8-connectivity
    thresh = zeros(s1, s2);
    low_thresh = low_thresh * max(max(BW));
    high_thresh = high_thresh * max(max(BW));

    for i = 1:s1
        for j = 1:s2
            if (BW(i, j) < low_thresh)
                thresh(i, j) = 0;
            elseif (BW(i, j) > high_thresh)
                thresh(i, j) = 1;
            elseif (BW(i+1,j) > high_thresh || BW(i-1,j) > high_thresh || BW(i,j+1) > high_thresh || BW(i,j-1) > high_thresh || BW(i-1, j-1) > high_thresh || BW(i-1, j+1) > high_thresh || BW(i+1, j+1) > high_thresh || BW(i+1, j-1) > high_thresh)
                thresh(i,j) = 1;
            end
        end
    end

    IEdge = uint8(thresh.*255);
end