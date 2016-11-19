function points3D = triangulate (corsSSD ,P1,P2) 
    points3D = [];
    for i = 1:size(corsSSD,1)
        A = [ corsSSD(i,2) * P1(3, :)-P1(1, :);
            corsSSD(i,1) * P1(3, :)-P1(2, :);
            corsSSD(i,4) * P2(3, :)-P2(1, :);
            corsSSD(i,3) * P2(3, :)-P2(2, :);];
        [U, S, V] = svd(A);
        points3D = [points3D, V(1:3, 4) / V(4, 4)];
    end
end