clear;
close all;
clc;


data=load('D:\FCM\FCM\iris.mat');
X=data.iris(:,1:4);
%figure; hold on;
X
%for i = 1 : rows (X)
   %plot (X(i, 1), X(i, 2), 'LineWidth', 2, ...
    %     'marker', 'x', 'color', 'b');
scatter (X(:,1), X(:,2),X(:,3), X(:,4),200, "filled");
hold on;
%scatter (X(:,3), X(:,4), 30, "x");
%hold on;
%scatter (X(:,1), X(:,3), 30, "o");
%hold on;
%endfor

