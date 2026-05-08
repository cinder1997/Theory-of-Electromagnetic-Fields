%% 圆柱导体中的恒定电流场
clear;clc;close all;
a=1;L=5;                 %圆柱导体的半径和高
V0=1;                    %上导体面的电位
sigma=5.96e7;            %铜的电导率
[r,theta,z]=meshgrid(linspace(0,a,10),linspace(0,2*pi,20),linspace(0,L,5));
u=V0/L.*z;               %电位
Er=zeros(size(r));       %电场
Etheta=zeros(size(theta));
Ez=V0/L.*ones(size(z));
[x,y,z,E_x,E_y,E_z] = cyl2cart(r,theta,z,Er,Etheta,Ez); %将柱坐标系下的矢量场转换到直角坐标系
J_x=sigma*E_x;           %电流密度场
J_y=sigma*E_y;
J_z=sigma*E_z;
figure;
quiver3(x,y,z,J_x,J_y,J_z);
view(3);    
axis equal; 
title('外加直流电压的圆柱导体中的电流密度分布');