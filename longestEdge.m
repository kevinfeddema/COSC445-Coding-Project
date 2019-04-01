function  results = longestEdge(lines,cent)

    max = 0;
    rho = -200;
    theta = -200;
    index = 1;
    found = 1;
    results = [0 0 0];
    
    for k = 1:length(lines)
        if rho ~= lines(k).rho || theta ~= lines(k).theta
            if max ~= 0
                point = max(pdist([lines(index).point1;cent], 'euclidean'),pdist([lines(index).point2;cent], 'euclidean'));
                if(point == pdist([lines(index).point1;cent], 'euclidean'))
                    results(found) = lines(index).point1;
                else
                    results(found) = lines(index).point2;
                end
                found = found + 1;
            end
            max = pdist([lines(k).point1,lines(k).point2]); 
            index = k;
            rho = lines(k).rho;
            theta = lines(k).theta;
        else
            dist = pdist([lines(k).point1,lines(k).point2]);
            max = max(max,dist);
            if k == length(lines)
                point = max(pdist([lines(index).point1;cent], 'euclidean'),pdist([lines(index).point2;cent], 'euclidean'));
                if(point == pdist([lines(index).point1;cent], 'euclidean'))
                    results(found) = lines(index).point1;
                else
                    results(found) = lines(index).point2;
                end
            end
        end
    end    

end