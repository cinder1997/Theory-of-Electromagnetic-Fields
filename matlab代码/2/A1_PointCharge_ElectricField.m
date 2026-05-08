%% 单个点电荷的电场
clear;clc;close all;
Q=1;                 %点电荷的电荷量
Q_x=0; Q_y=0; Q_z=0; %点电荷的坐标
epsilon0=8.854e-12;
[x,y,z]=meshgrid(linspace(-10,10,10));
R=sqrt((x-Q_x).^2+(y-Q_y).^2+(z-Q_z).^2);
Ex=1/(4*pi*epsilon0)*Q.*(x-Q_x)./(R.^3);  %电场
Ey=1/(4*pi*epsilon0)*Q.*(y-Q_y)./(R.^3);
Ez=1/(4*pi*epsilon0)*Q.*(z-Q_z)./(R.^3);
phi=1/(4*pi*epsilon0).*(Q./R);            %电位

figure;
plot3(Q_x,Q_y,Q_z, 'b.', 'MarkerSize', 8, 'LineWidth', 2);  %绘制点电荷
hold on;
quiver3(x,y,z,Ex,Ey,Ez,'b','LineWidth',1);                  %使用quiver3绘制电场
% r0=0.01;                                        
% theta0=linspace(0,pi,6);
% phi0=linspace(0,2*pi,10);
% start_x=r0*sin(theta0)'*cos(phi0)+Q_x;                    
% start_y=r0*sin(theta0)'*sin(phi0)+Q_y;                 
% start_z=r0*cos(theta0)'*ones(1,length(phi0))+Q_z;
% streamline(x,y,z,Ex,Ey,Ez,start_x,start_y,start_z);         %使用streamline同样可以绘制电场，更美观，但是无法指示大小和方向
hold on;
[f,v]=isosurface(x,y,z,phi,0.5*max(phi(:)));                  %计算等势面对应的面元和顶点
p=patch('Faces',f,'Vertices',v);                              %绘制等势面
set(p,'FaceColor','red','EdgeColor','none','FaceAlpha',0.3);  %修饰等势面，面元颜色、边线颜色、透明度
[f,v]=isosurface(x,y,z,phi,0.3*max(phi(:)));                
p=patch('Faces',f,'Vertices',v);                            
set(p,'FaceColor','red','EdgeColor','none','FaceAlpha',0.1);
view(3);    %以三维视角显示
axis equal; %等比例显示
camlight;   %设置光线
xlabel('x');ylabel('y');zlabel('z');
title('点电荷的电场');


%% 一对异号点电荷的电场
Q1=1;Q2=-1;     
Q1_x=2; Q1_y=0; Q1_z=0;
Q2_x=-2; Q2_y=0; Q2_z=0;
epsilon0=8.854e-12;
[x,y,z]=meshgrid(linspace(-10,10,30));
R1=sqrt((x-Q1_x).^2+(y-Q1_y).^2+(z-Q1_z).^2);
R2=sqrt((x-Q2_x).^2+(y-Q2_y).^2+(z-Q1_z).^2);
Ex=1/(4*pi*epsilon0)*( Q1.*(x-Q1_x)./(R1.^3)+Q2.*(x-Q2_x)./(R2.^3) );  %电场
Ey=1/(4*pi*epsilon0)*( Q1.*(y-Q1_y)./(R1.^3)+Q2.*(y-Q2_y)./(R2.^3) );
Ez=1/(4*pi*epsilon0)*( Q1.*(z-Q1_z)./(R1.^3)+Q2.*(z-Q2_z)./(R2.^3) );
phi=1./(4*pi*epsilon0).*(Q1./R1+Q2./R2);  %电位

figure;
plot3(Q1_x,Q1_y,Q1_z, 'r.', 'MarkerSize', 8, 'LineWidth', 2); %绘制点电荷
hold on;
plot3(Q2_x,Q2_y,Q2_z, 'b.', 'MarkerSize', 8, 'LineWidth', 2); %绘制点电荷
hold on;
quiver3(x,y,z,Ex,Ey,Ez,'b','LineWidth',1);                  %使用quiver3绘制电场
hold on;
[f,v]=isosurface(x,y,z,phi,0.3*max(phi(:)));                  %计算等势面对应的面元和顶点
p=patch('Faces',f,'Vertices',v);                              %绘制等势面
set(p,'FaceColor','red','EdgeColor','none','FaceAlpha',0.3);  %修饰等势面，面元颜色、边线颜色、透明度
[f,v]=isosurface(x,y,z,phi,0.1*max(phi(:)));                
p=patch('Faces',f,'Vertices',v);                            
set(p,'FaceColor','red','EdgeColor','none','FaceAlpha',0.1);
[f,v]=isosurface(x,y,z,phi,-0.3*max(phi(:)));                 
p=patch('Faces',f,'Vertices',v);      
set(p,'FaceColor','blue','EdgeColor','none','FaceAlpha',0.3); 
[f,v]=isosurface(x,y,z,phi,-0.1*max(phi(:)));                
p=patch('Faces',f,'Vertices',v);                            
set(p,'FaceColor','blue','EdgeColor','none','FaceAlpha',0.1);
view(3);    %以三维视角显示
axis equal; %等比例显示
camlight;   %设置光线
xlabel('x');ylabel('y');zlabel('z');
title('一对异号点电荷的电场');