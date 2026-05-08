%% 真空中圆环状带电导线的电场
clear;clc;close all;
Q=1;               %总电荷量
a=1;               %半径
epsilon0=8.854e-12;
[x, y, z] = meshgrid(linspace(-3,3,20),linspace(-3,3,20), linspace(-2,2,5)); % 创建网格
hx=x(1,2,1)-x(1,1,1);hy=y(2,1,1)-y(1,1,1);hz=z(1,1,2)-z(1,1,1);
r=sqrt(x.^2+y.^2);
k=sqrt( 4*r*a./((r+a).^2+z.^2) );
phi=Q/(2*pi*pi*epsilon0).*ellipticK(k)./sqrt((r+a).^2+z.^2);   %电位
[Ex,Ey,Ez]=gradient(-phi,hx,hy,hz); %数值方法计算电位的梯度，即电场

figure;
loop_x=a.*cos(linspace(0,2*pi,30));
loop_y=a.*sin(linspace(0,2*pi,30));
loop_z=0.*linspace(0,2*pi,30);
plot3(loop_x,loop_y,loop_z,'r','LineWidth',2); %绘制圆环形导线
hold on;
quiver3(x, y, z, Ex, Ey, Ez);               %绘制电场
axis equal;
xlabel('x');ylabel('y');zlabel('z');
title('真空中圆环状带电导线的电场');