%% 计算矢量函数的散度
clear;clc;close all;
[x,y]=meshgrid(linspace(-2,2,100));
r=sqrt(x.^2+y.^2);
Ax=x./r.^3;
Ay=y./r.^3;
figure;
quiver(x,y,Ax,Ay);                 %绘制二维矢量场
xlim([-0.2 0.2]);
ylim([-0.2 0.2]);
title("矢量场")

A_Div=divergence(x,y,Ax,Ay);       %数值方法计算矢量场的散度
figure;
contour(x,y,A_Div,'Fill','on');
title("矢量场的散度")


syms x y;
r=sqrt(x.^2+y.^2);
A=[x./r.^3,y./r.^3];
A_divergence=divergence(A,[x y])   %解析方法计算矢量场的散度
