function [I, corsSSD] = naiveCorrespondanceMatching(I1, I2, corners1, corners2, R, SSDth)
    M = [max(size(I1,1),size(I2,1)) max(size(I1,2),size(I2,2))];
    I1 = padarray(I1,[M(1)-size(I1,1) M(2)-size(I1,2)],0,'post');
    I2 = padarray(I2,[M(1)-size(I2,1) M(2)-size(I2,2)],0,'post');
    I = [I1,I2];

    %% 
    corsSSD = zeros(size(corners1,1),1);
    for i = 1:size ( corners1 ,1)
        minSSD = inf;
        idx = 0;
        win1 = I1(corners1(i, 1) - R:corners1(i, 1) + R,corners1(i, 2) - ...
            R:corners1(i, 2) + R); 
        for j = 1:size(corners2 ,1);
            win2 = I2(corners2(j, 1) - R:corners2(j, 1) + R,corners2(j, 2) ...
                - R:corners2(j, 2) + R);
            oSSD = SSDmatch ( win1 , win2 ) ;
            if(oSSD < minSSD)
                minSSD = oSSD;
                idx = j;
            end
        end
        if(minSSD < SSDth)
            corsSSD(i) = idx;
        end  
    end


end

