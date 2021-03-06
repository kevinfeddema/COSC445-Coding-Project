function IEdge = getEdges(ISkew, low_thresh, high_thresh, sigma)

    %best values seem to be low_thresh = 0.08, high_thresh = 0.2, sigma = 1

    %STEP 1: Smooth image using gaussian filter
    ISmooth = imgaussfilt(ISkew, sigma);

    %STEP 2: Compute the gradient magnitude and angle

    %filters for horizontal and vertical direction
    wx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
    wy = [1, 2, 1; 0, 0, 0; -1, -2, -1];

    %apply filters
    filter_x = conv2(ISmooth, wx, 'same');
    filter_y = conv2(ISmooth, wy, 'same');

    %calculate gradient magnitude
    magnitude = sqrt((filter_x.^2) + (filter_y.^2));

    %calculate gradient direction
    direction = atan2(filter_y, filter_x);
    direction = direction*180/pi;

    M = size(ISmooth, 1);
    N = size(ISmooth, 2);

    %make all directions positive
    for i = 1:M
        for j = 1:N
            if (direction(i,j) < 0) 
                direction(i,j) = direction(i,j) + 180;
            end
        end
    end

    direction4 = zeros(M, N);

    %adjust to only 4 directions (0, 45, 90, 135)
    for i = 1:M
        for j = 1:N
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

    E = zeros(M, N);

    %STEP 3: Apply Nonmaxima Suppression
    for i = 2:M-1
        for j = 2:N-1
            switch(direction4(i,j))
                case 0
                    E(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i,j+1), magnitude(i,j-1)]));
                case 45
                    E(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j-1), magnitude(i-1,j+1)]));
                case 90
                    E(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j), magnitude(i-1,j)]));
                case 135
                    E(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j+1), magnitude(i-1,j-1)]));
            end
        end
    end

    E = E.*magnitude;

    %STEP 4: Double Thresholding and Connectivity Analysis using 8-connectivity
    edges = zeros(M, N);
    low_thresh = low_thresh * max(max(E));
    high_thresh = high_thresh * max(max(E));

    for i = 1:M
        for j = 1:N
            if (E(i, j) < low_thresh)
                edges(i, j) = 0;
            elseif (E(i, j) > high_thresh)
                edges(i, j) = 1;
            elseif (E(i+1,j) > high_thresh || E(i-1,j) > high_thresh || E(i,j+1) > high_thresh || E(i,j-1) > high_thresh || E(i-1, j-1) > high_thresh || E(i-1, j+1) > high_thresh || E(i+1, j+1) > high_thresh || E(i+1, j-1) > high_thresh)
                edges(i,j) = 1;
            end
        end
    end

    IEdge = uint8(edges.*255);
end