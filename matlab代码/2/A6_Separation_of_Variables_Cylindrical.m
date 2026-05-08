%% 圆柱坐标系下使用分离变量法计算圆柱导体内的电位和电场
clear;clc;close all;
% % 使用符号计算获取一阶贝塞尔函数的前三个零点
% syms x
% zero(1) = vpasolve(besselj(1, x) == 0, x, 3.8);
% zero(2) = vpasolve(besselj(1, x) == 0, x, 7.0);
% zero(3) = vpasolve(besselj(1, x) == 0, x, 10.2)

a=1;L=5;                 %圆柱导体的半径和高
V0=1;                    %上导体面的电位
[r,theta,z]=meshgrid(linspace(0,a,10),linspace(0,2*pi,20),linspace(0,L,5));
u=V0/L.*z;               %电位
Er=zeros(size(r));       %电场
Etheta=zeros(size(theta));
Ez=V0/L.*ones(size(z));
[x,y,z,E_x,E_y,E_z] = cyl2cart(r,theta,z,Er,Etheta,Ez); %将柱坐标系下的矢量场转换到直角坐标系
figure;
quiver3(x,y,z,E_x,E_y,E_z);
view(3);    
axis equal; 
title('外加直流电压的圆柱导体的电场');