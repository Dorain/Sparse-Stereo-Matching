% str = 'dino';
str = 'warrior';
% str = 'matrix';
load(strcat(str,'2.mat'));
img1 = rgb2gray(eval(strcat(str,'01')));
img2 = rgb2gray(eval(strcat(str,'02')));
[m1, n1] = size(img1);
[m2, n2] = size(img2); 
T=fund(cor1, cor2);
cornersCnt = size(cor1 , 1);
subplot (1 ,2 ,1); 
imshow(img1); hold on; 
subplot (1 ,2 ,2); 
imshow(img2);

for i = 1:cornersCnt 
    x1=[cor1(i,:),1]'; 
    x2=[cor2(i,:),1]';
    l2 = T*x1; l1 = T'*x2;
    p1=linePts(l1,[0 n1],[0 m1]); 
    p2=linePts(l2,[0 n2],[0 m2]); hold on ;
    subplot (1 ,2 ,1);
    plot(x1(1, 1), x1(2, 1), 'o', 'LineWidth',2, 'MarkerSize', 20, 'MarkerEdgeColor','b'); 
    plot(p1(:,1),p1(:,2), '-', 'Color','b');
    hold on ;
    subplot (1 ,2 ,2);
    plot(p2(:,1),p2(:,2),'-', 'Color','b');
    plot(x2(1, 1), x2(2, 1), 'o', 'LineWidth',2, 'MarkerSize', 20, 'MarkerEdgeColor','b'); 
end