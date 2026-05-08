%% 计算标量函数的梯度
clear;clc;close all;
[x,y]=meshgrid(linspace(-2,2,20));
hx=x(1,2)-x(1,1);hy=y(2,1)-y(1,1);
z=exp(-x.^2 - y.^2);            %定义二维标量场z(x,y)
contour(x,y,z,'Fill','on');     %绘制二维标量场等值线图
title("标量场");

[Grad_x,Grad_y]=gradient(z,hx,hy);    %数值方法计算标量场的梯度。
figure;
quiver(x,y,Grad_x,Grad_y);    %绘制二维标量场的梯度图
title("标量场的梯度");


syms x y;       
z=exp(-x.^2 - y.^2);
z_gradient=gradient(z)          %解析方法计算标量场的梯度

