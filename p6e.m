% str = 'dino';
% str = 'warrior';
str = 'matrix';
load(strcat(str,'2.mat'));
I1 = rgb2gray(eval(strcat(str,'01')));
I2 = rgb2gray(eval(strcat(str,'02')));
ncorners = 10;
F = fund(cor1, cor2);
%%
smoothSTD = 25;
windowSize = 20;
corners1 = CornerDetect(I1, ncorners, smoothSTD, windowSize);
%% 
R = 20;
SSDth = 80;
corsSSD = correspondanceMatchingLine( I1, I2, corners1, F, R, SSDth);

 %% plot
M = [max(size(I1,1),size(I2,1)) max(size(I1,2),size(I2,2))];
I1 = padarray(I1,[M(1)-size(I1,1) M(2)-size(I1,2)],0,'post');
I2 = padarray(I2,[M(1)-size(I2,1) M(2)-size(I2,2)],0,'post');
I = [I1,I2];
imshow(I);
[m1, n1] = size(I1);
[m2, n2] = size(I2); 
m=max(m1, m2);
n=max(n1, n2);
for i = 1:size(corsSSD, 1)
    p1 = corsSSD(i,1:2);
    p2 = corsSSD(i,3:end);
    hold on
    plot(p1(1), p1(2), 'o', 'LineWidth',2,'MarkerSize', 20, 'MarkerEdgeColor','r'); hold on
    plot(p2(1)+n, p2(2), 'o', 'LineWidth',2,'MarkerSize', 20, 'MarkerEdgeColor','r'); hold on
    X= [p1(1), p2(1)+n]; 
    Y= [p1(2), p2(2)];
    plot(X, Y, 'Color','b'); 
end