% str = 'dino';
str = 'warrior';
% str = 'matrix';
load(strcat(str,'2.mat'));
I1 = rgb2gray(eval(strcat(str,'01')));
I2 = rgb2gray(eval(strcat(str,'02')));
outlierTH = 20;
F = fund(cor1, cor2);
ncorners = 50;
P1=eval(['proj_', str, '01']); 
P2=eval(['proj_', str, '02']);
%%
smoothSTD = 25;
windowSize = 20;
corners1 = CornerDetect(I1, ncorners, smoothSTD, windowSize);
corsSSD = correspondanceMatchingLine( I1, I2, corners1, F, R, SSDth);
%%
points3D = triangulate(corsSSD, P1, P2);
%%
% [ inlier, outlier ] = findOutliers(points3D, P2, outlierTH, corsSSD);

    inlier = [];
    outlier = [];
    for i = 1:size(corsSSD,1)
        p3d_homo=[points3D(:, i); 1];
        p2 = corsSSD(i,3:4);
        p2 = [p2(2),p2(1)]';
        p2_proj = P2*p3d_homo;
        p2_proj = p2_proj(1:2)/ p2_proj(3);
        if norm(p2-p2_proj) < outlierTH 
           inlier = [ inlier , p2_proj ];
        else
           outlier = [ outlier , p2_proj ]; 
        end
    end

%%
imshow(I2);
for i = 1:size(corsSSD, 1)
    p2 = corsSSD(i, 3:4);
    hold on
    plot(p2(1), p2(2), 'o', 'LineWidth',2,'MarkerSize', 20, 'MarkerEdgeColor','black'); hold on

end
%%
hold on
for i = 1:size(inlier , 2)
    p=inlier(:,i);
    hold on
    plot(p(2), p(1), '+', 'LineWidth',2,'MarkerSize', 20, 'MarkerEdgeColor','b');
end
%%
hold on
for i = 1:size(outlier , 2)
    p=outlier(:,i);
    hold on
    plot(p(2) , p(1) , '+' , 'LineWidth',2,'MarkerSize', 20, 'MarkerEdgeColor', 'r' );
end
