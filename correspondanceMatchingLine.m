function corsSSD = correspondanceMatchingLine( I1,  I2,  corners1,  F,  R,  SSDth);
    corsSSD = []; 
    for i = 1: size(corners1, 1)
        l = F*[corners1(i, : ), 1]';
        pts = linePts(l, [1, size(I2, 1)],  [1,  size(I2, 2)]);
        window1 = I1(corners1(i, 2)-R: corners1(i, 2)+R, corners1(i, 1)-R: ...
            corners1(i, 1)+R); 
        score = [];
        for u = pts(1, 1)+R: pts(2, 1)-R
            v = int32(-(l(3)+l(1)*u)/l(2)); 
            if(v<=R || v> size(I2, 2)-R)
                continue ;
            end
            window2 = I2(v-R: v+R, u-R: u+R);
            score = [ score ; SSDmatch(window1 ,  window2 ) ] ;
        end
        idx = find(score == min(score ));
        if(score(idx) < SSDth)
            x = pts(1, 1)+R+idx-1;
            y = -(l(3)+l(1)*idx)/l(2);
            corsSSD = [corsSSD,  [corners1(i,  : ),  x, y ]'];
        end 
    end
    corsSSD = corsSSD';
end

