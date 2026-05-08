%% 真空中一无限长直导线的电场
close all;clear;clc;
rho=1;   %线电荷密度
epsilon0=8.854e-12;
[r,theta,z]=meshgrid(linspace(1,5,10),linspace(0,2*pi,20),linspace(-3,3,3));
Er=rho./(epsilon0*2*pi.*r); %电场
Etheta=zeros(size(Er));
Ez=zeros(size(Er));
phi=rho./(2*pi*epsilon0).*log(r); %电位，以r=1为零电位参考面
[x,y,z,E_x,E_y,E_z] = cyl2cart(r,theta,z,Er,Etheta,Ez); %将柱坐标系下的矢量场转换到直角坐标系

figure;
plot3(zeros(1,30),zeros(1,30),linspace(-3,3,30),'r','LineWidth', 2); %绘制直导线
hold on;
quiver3(x,y,z,E_x,E_y,E_z,'b');
hold on;
% [f,v]=isosurface(x,y,z,phi,0.5*max(phi(:)));   %计算等势面对应的面元和顶点
% p=patch('Faces',f,'Vertices',v); %绘制等势面
% set(p,'FaceColor','red','EdgeColor','none','FaceAlpha',0.3);%修饰等势面，面元颜色、边线颜色、透明度
% [f,v]=isosurface(x,y,z,phi,0.2*max(phi(:))); 
% p=patch('Faces',f,'Vertices',v); 
% set(p,'FaceColor','red','EdgeColor','none','FaceAlpha',0.1);
view(3);    
axis equal; 
camlight;  
xlabel('x');ylabel('y');zlabel('z');
title('无限长带电直导线的电场');
