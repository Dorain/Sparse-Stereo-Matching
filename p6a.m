% str = 'dino';
% str = 'warrior';
str = 'matrix';
load(strcat(str,'2.mat'));
img1 = rgb2gray(eval(strcat(str,'01')));
img2 = rgb2gray(eval(strcat(str,'02')));
%% parameters

nCorners = 20;
smoothSTD = 25;
windowSize = 20;
% Image = img1;
Image = img2;

[corners] = CornerDetect(Image, nCorners, smoothSTD, windowSize);
%% plot
f = figure;
hold on;
imshow( Image ) ;
% To eliminate immediate neighbor corners , increase window size
for i = 1:nCorners 
    hold on;
% plot x, y is swapped.
    plot(corners(i, 1), corners(i, 2), 'o', 'LineWidth',2, 'MarkerSize', 20, 'MarkerEdgeColor','b');
end
title(strcat(str,'2'));
% saveas(f, strcat(str,'2.jpg'));