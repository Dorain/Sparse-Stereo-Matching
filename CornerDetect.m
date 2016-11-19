function [corners] = CornerDetect(Image, nCorners, smoothSTD, windowSize)
    %% gaussian smoothing
    h = fspecial('gaussian', [windowSize, windowSize], smoothSTD);
    img_sm = imfilter(Image, h, 'replicate', 'conv');
    %% Ix,Iy
    Sx = [-1 0 1;-2 0 2;-1 0 1];
    Sy = [-1 -2 -1;0 0 0;1 2 1];
    Ix = imfilter(img_sm, Sx, 'replicate', 'conv');
    Iy = imfilter(img_sm, Sy, 'replicate', 'conv');
    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    Ixy = Ix.*Iy;
    %% C and eigenvalue
    [M,N] = size(Image);
    e = zeros(M,N);
    for i = 1:M-windowSize+1
        for j = 1:N-windowSize+1
            C=zeros(2);
            C(1,1)=sum(sum( Ix2 ( i : i+windowSize -1, j : j+windowSize -1))); 
            C(1,2)=sum(sum( Ixy ( i : i+windowSize -1, j : j+windowSize -1)));
            C(2,1)=C(1,2);
            C(2,2)=sum(sum( Iy2 ( i : i+windowSize -1,j : j+windowSize -1)));
            e(i+ceil(windowSize/2), j + ceil(windowSize/2)) = min(eig(C));
        end

    end
    %% local maximum and threshold
    nms_size = 10;
    nms =zeros(size(e));
    % for i = 1:size(e,1)-nms_size+1
    %     for j = 1:size(e,2)-nms_size+1
    %         if(
    e_sort = sort(e(:),'descend'); 
    idx=1;
    cnt = 1;
    corners = zeros(nCorners,2);
    while(cnt<nCorners+1)
        [y,x] = find(e == e_sort(idx));
        neibor = e(max(y-nms_size ,1):min(y+nms_size ,size(e,1)) ,...
        max(x-nms_size ,1):min(x+nms_size ,size(e,2))); 
        if(e(y,x) == max(neibor(:)))
            corners(cnt ,:) = [x,y];
    %         corners(y,x) = 1;
            cnt = cnt + 1;
        end
        idx = idx + 1;
    end
end