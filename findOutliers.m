function [ inlier , outlier ] = findOutliers (points3D , P2, outlierTH , corsSSD) 
    inlier = [];
    outlier = [];
    for i = 1:size(corsSSD,1)
        p3d_homo=[points3D(:, i); 1];
        p2 = corsSSD(i,3:4);
        p2 = [p2(2),P2(1)]';
        p2_proj = P2*p3d_homo;
        p2_proj = p2_proj(1:2)/ p2_proj(3);
        if norm(p2-p2_proj) < outlierTH 
           inlier = [ inlier , p2_proj ];
        else
           outlier = [ outlier , p2_proj ]; 
        end
    end
end


% N = size(ssdCor ,1)/2;
% Pr = ssdCor(2:2:2*N,:); inlier = [];
% outlier = [];
% for i = 1:N
%     p2 = P2*points3D(i ,:)'; 
%     p2 = p2./p2(3);
%     p2_gt = Pr(i ,:)';
%     if(norm(p2(1:2) - p2_gt) > outlierTH) 
%         outlier = [ outlier ;p2(1:2)'];
%             
%     else
%     inlier = [ inlier ;p2(1:2)'];
%     end
% end
% 
%         
% end

