%% 镜像法求接地导体平面附近电荷的电场
clear;clc;close all;
Q=1;                 %点电荷的电荷量
Q_x=0; Q_y=0; Q_z=3; %点电荷的坐标
epsilon0=8.854e-12;
[x,y,z]=meshgrid(linspace(-10,10,20),linspace(-10,10,20),linspace(0,5,10));
R_p=sqrt((x-Q_x).^2+(y-Q_y).^2+(z-Q_z).^2);
R_n=sqrt((x-Q_x).^2+(y-Q_y).^2+(z+Q_z).^2);
Ex=1/(4*pi*epsilon0)*Q.*(x-Q_x).*(1./R_p.^3-1./R_n.^3);  %电场
Ey=1/(4*pi*epsilon0)*Q.*(y-Q_y).*(1./R_p.^3-1./R_n.^3);
Ez=1/(4*pi*epsilon0)*Q.*((z-Q_z)./R_p.^3-(z+Q_z)./R_n.^3);
rho=epsilon0.*Ez(:,:,1);     %导体平面的面电荷密度

figure;
plot3(Q_x,Q_y,Q_z, 'r.', 'MarkerSize', 18, 'LineWidth', 2);  %绘制点电荷
hold on;
quiver3(x,y,z,Ex,Ey,Ez,'r','LineWidth',1);                  %绘制电场
contour(x(:,:,1),y(:,:,1),abs(rho),'fill','on');            %绘制导体平面的面电荷密度
colorbar;
view(3);   
axis equal;
camlight;   
xlabel('x');ylabel('y');zlabel('z');
title('接地导体平面附近电荷的电场');