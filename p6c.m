% str = 'dino';
% str = 'warrior';
str = 'matrix';
load(strcat(str,'2.mat'));
img1 = rgb2gray(eval(strcat(str,'01')));
img2 = rgb2gray(eval(strcat(str,'02')));
Image = img1;
% Image = img2;
smoothSTD = 25;
windowSize = 20;
ncorners = 10;
corners1 = CornerDetect(img1, ncorners, smoothSTD, windowSize);
corners2 = CornerDetect(img2, ncorners, smoothSTD, windowSize);
%% 
R = 60;
SSDth = 500;
I1 = img1;
I2 = img2;
[I, corsSSD] = naiveCorrespondanceMatching(I1, I2, corners1, corners2, R, SSDth);

%% plot
imshow(I);
[m1, n1] = size(I1);
[m2, n2] = size(I2); 
m=max(m1, m2);
n=max(n1, n2);
for i = 1:size(corsSSD, 1)
    if(corsSSD(i)~= 0)
    p1 = corners1(i,:);
    p2 = corners2(corsSSD(i),:);
    hold on
    plot(p1(1), p1(2), 'o', 'LineWidth',2,'MarkerSize', 20, 'MarkerEdgeColor','r'); hold on
    plot(p2(1)+n, p2(2), 'o', 'LineWidth',2,'MarkerSize', 20, 'MarkerEdgeColor','r'); hold on
    X= [p1(1), p2(1)+n]; 
    Y= [p1(2), p2(2)];
    plot(X, Y, 'Color','b'); 
    end
end
