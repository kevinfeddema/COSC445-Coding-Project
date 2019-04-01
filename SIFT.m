function [x12, y12,x6, y6,x10, y10,x4, y4]= SIFT(IClock, twelve,six,ten,four)

    %I = imresize(I,[600,1000]);
    clock = IClock;
    IClock = single(IClock);
%     twelve = imread('images/Clock219_12.jpg');
%     nine = imread('images/Clock219_10.jpg');
%     three  = imread('images/Clock219_4.jpg');
%     six = imread('images/Clock219_6.jpg');

%     twelve  =  rgb2gray(twelve);
%     nine = rgb2gray(nine);
%     three = rgb2gray(three);
%     six =  rgb2gray(six);

    twelve = single(twelve);
    ten = single(ten);
    four = single(four);
    six = single(six);

%     imshow(IClock,[]);

    peak_thresh = 5;
    edge_thresh = 15;
    [f1,d1] = vl_sift(IClock,'PeakThresh',peak_thresh,'edgethresh',edge_thresh);

%     h = vl_plotframe(f1) ; 
%     set(h,'color','r','linewidth',1) ; 

    [f12,d12] = vl_sift(twelve,'PeakThresh', peak_thresh,'edgethresh', edge_thresh); 
    [f10,d10] =  vl_sift(ten,'PeakThresh', peak_thresh,'edgethresh', edge_thresh);
    [f4,d4] =  vl_sift(four,'PeakThresh', peak_thresh,'edgethresh', edge_thresh); 
    [f6,d6] =  vl_sift(six,'PeakThresh', peak_thresh,'edgethresh', edge_thresh);

    % figure, imshow(nine,[]);
    % h = vl_plotframe(f12) ; 
    % set(h,'color','y','linewidth',2) ; 

    thresh = 4;
    [matches12, scores12] = vl_ubcmatch(d1, d12, thresh); 
    indices12 = matches12(1,:);
    f12match = f1(:,indices12); 
    d12match = d1(:,indices12); 

    [matches10, scores10] = vl_ubcmatch(d1, d10, thresh); 
    indices10 = matches10(1,:);
    f10match = f1(:,indices10); 
    d10match = d1(:,indices10); 

    [matches4, scores4] = vl_ubcmatch(d1, d4, thresh); 
    indices4 = matches4(1,:);
    f4match = f1(:,indices4); 
    d4match = d1(:,indices4); 

    [matches6, scores6] = vl_ubcmatch(d1, d6, thresh); 
    indices6 = matches6(1,:);
    f6match = f1(:,indices6); 
    d6match = d1(:,indices6); 
    % indices2 = matches(2,:); 
    % f2match = f2(:,indices2); 
    % d2match = d2(:,indices2);

    % figure,imshow(clock);
    % for i=1:size(f12match,2) 
    %     x = f12match(1,i);
    %     y = f12match(2,i); 
    %     text(x,y,sprintf('%d',i), 'Color', 'g'); 
    % end

    figure, imshow(clock); hold on;
    x12 = 0;
    y12 = 0;
    n = 0;
    err = 0;
    for i = 1 : size(matches12,2)
        err = 0;
        for j = 1 : size(matches12,2)
            dist =  [f12match(1,i),f12match(2,i);f12match(1,j),f12match(2,j)];
            if  pdist(dist,'euclidean') < 75
                err = err + 1;
            end
        end
        if err > 4
            x12 = x12 + f12match(1,i);
            y12 = y12 + f12match(2,i);
            n = n + 1;
        end
    end
    x12 = x12/n;
    y12 = y12/n;
    plot(x12,y12,'r+','MarkerSize',6);

    x4  =  0;
    y4  = 0;
    n  = 0;
    for i = 1 : size(matches4,2)
        err = 0;
        if pdist([f4match(1,i),f4match(2,i);x12,y12]) > (size(IClock,2) * .25)
            for j = 1 : size(matches4,2)
                dist =  [f4match(1,i),f4match(2,i);f4match(1,j),f4match(2,j)];
                if  pdist(dist,'euclidean') < 100
                    err = err + 1;
                end
            end
            if err > 3
                x4 = x4 + f4match(1,i);
                y4 = y4 + f4match(2,i);
                n = n + 1;
            end
        end
    end
    x4 = x4/n;
    y4 = y4/n;
    plot(x4,y4,'r+','MarkerSize',6);

    x10 =0;
    y10 = 0;
    n =  0;
    for i = 1 : size(matches10,2)
        err = 0;
        if pdist([f10match(1,i),f10match(2,i);x4,y4]) > (size(IClock,2) * .25)
            for j = 1 : size(matches10,2)
                dist = [f10match(1,i),f10match(2,i);f10match(1,j),f10match(2,j)];
                if  pdist(dist,'euclidean') < 200
                    err = err + 1;
                end
            end
            if err > 3
                x10 = x10 + f10match(1,i);
                y10 = y10 + f10match(2,i);
                n = n + 1;
            end
        end
    end
    x10 = x10/n;
    y10 = y10/n;
    plot(x10,y10,'r+','MarkerSize',6);

    x6 = 0;
    y6 = 0;
    n = 0;
    for i = 1 : size(matches6,2)
        err = 0;
        if pdist([f6match(1,i),f6match(2,i);x12,y12]) > (size(IClock,1) * .6)
            for j = 1 : size(matches6,2)
                dist = [f6match(1,i),f6match(2,i);f6match(1,j),f6match(2,j)];
                if  pdist(dist,'euclidean') < 200
                    err = err + 1;
                end
            end
            if err > 3
                x6 = x6 + f6match(1,i);
                y6 = y6 + f6match(2,i);
                n = n + 1;
            end
        end
    end
    x6 = x6/n;
    y6 = y6/n;
    plot(x6,y6,'r+','MarkerSize',6);

end