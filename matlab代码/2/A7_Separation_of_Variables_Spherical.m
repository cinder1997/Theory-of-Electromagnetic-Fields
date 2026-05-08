%% 球坐标系下使用分离变量法计算导体球外的电位和电场
clear;clc;close all;
a=1;                 %导体球的半径
E0=1;                %球外电场大小
[x, y, z] = meshgrid(linspace(0,-2,5),linspace(-2,2,10), linspace(-2,2,10)); % 创建网格
hx=x(1,2,1)-x(1,1,1);hy=y(2,1,1)-y(1,1,1);hz=z(1,1,2)-z(1,1,1);
r=sqrt(x.^2+y.^2+z.^2);
theta=atan2(sqrt(x.^2+y.^2),z);
phi=atan2(y,z);

r(abs(r)<a)=NaN;                   %不计算导体球内部的电位
u_out=E0.*(r-a^3./r.^2).*cos(theta);   %球外空间的电位
[Ex,Ey,Ez]=gradient(-u_out,hx,hy,hz);  %数值方法计算电位的梯度，即电场
figure;
quiver3(x,y,z,Ex,Ey,Ez,'red');
hold on;
[Sx, Sy, Sz] = sphere(50);  % 绘制导体球
mask = Sx <= 0;
X_half = a.*Sx .* mask;
Y_half = a.*Sy .* mask;
Z_half = a.*Sz .* mask;
surf(X_half, Y_half, Z_half,'FaceColor', 'b','FaceAlpha', 0.5,'EdgeColor',"#0072BD");
axis equal
title('导体球附近的电场');


%% 球坐标系下使用分离变量法计算介质球内外的电位和电场
a=1.5;                 %介质球的半径
E0=1;                %球外电场大小
epsilon0=8.854e-12;
epsilon1=3*epsilon0;
[x, y, z] = meshgrid(linspace(0,-2,5),linspace(-2,2,10), linspace(-2,2,10)); % 创建网格
hx=x(1,2,1)-x(1,1,1);hy=y(2,1,1)-y(1,1,1);hz=z(1,1,2)-z(1,1,1);
r=sqrt(x.^2+y.^2+z.^2);
theta=atan2(sqrt(x.^2+y.^2),z);
phi=atan2(y,z);

r_out=r;r_in=r;
r_out(abs(r_out)<a)=NaN;    
r_in(abs(r_in)>a)=NaN; 
u_in=(3*epsilon0)/(epsilon1+2*epsilon0)*E0.*r_in.*cos(theta);  %球内的电位
u_out=(E0.*r_out+(epsilon0-epsilon1)/(epsilon1+2*epsilon0)*E0*a^3./r_out.^2).*cos(theta); %球外的电位
[Ex_in,Ey_in,Ez_in]=gradient(-u_in,hx,hy,hz);      %计算球内的电场
[Ex_out,Ey_out,Ez_out]=gradient(-u_out,hx,hy,hz);  %计算球外的电场
figure;
quiver3(x,y,z,Ex_in,Ey_in,Ez_in,'green');
hold on;
quiver3(x,y,z,Ex_out,Ey_out,Ez_out,'red');
hold on;
[Sx, Sy, Sz] = sphere(50);  % 绘制介质球
mask = Sx <= 0;
X_half = a.*Sx .* mask;
Y_half = a.*Sy .* mask;
Z_half = a.*Sz .* mask;
surf(X_half, Y_half, Z_half,'FaceColor', "#7E2F8E",'FaceAlpha', 0.5,'EdgeColor',"#0072BD");
axis equal
title('介质球附近的电场');

%% 绘制YOZ平面图
% a=1;                 %导体球的半径
% E0=1;                %球外电场大小
% [y, z] = meshgrid(linspace(-2,2,20), linspace(-2,2,20)); % 创建网格
% hy=y(1,2)-y(1,1);hz=z(2,1)-z(1,1);
% r=sqrt(y.^2+z.^2);
% theta=atan2(sqrt(y.^2),z);
% r(abs(r)<(a-hy))=NaN;                       %不计算导体球内部的电位
% u_out=E0.*(r-a^3./r.^2).*cos(theta);   %球外空间的电位
% [Ey,Ez]=gradient(-u_out,hy,hz);        %数值方法计算电位的梯度，即电场
% figure;
% quiver(y,z,Ey,Ez,'blue');
% hold on;
% Sy = a * cos(0:0.01*pi:2*pi);
% Sz = a * sin(0:0.01*pi:2*pi);
% patch(Sy, Sz, [0.8 0.8 0.8], 'EdgeColor', 'r', 'LineWidth', 1.5);
% axis equal
% title('导体球附近的电场');
% 
% a=1;                 %介质球的半径
% E0=1;                %球外电场大小
% epsilon0=8.854e-12;
% epsilon1=3*epsilon0;
% [y, z] = meshgrid(linspace(-2,2,20), linspace(-2,2,20)); % 创建网格
% hy=y(1,2)-y(1,1);hz=z(2,1)-z(1,1);
% r=sqrt(y.^2+z.^2);
% theta=atan2(sqrt(y.^2),z);
% r_out=r;r_in=r;
% r_out(abs(r_out)<(a-hy))=NaN;    
% r_in(abs(r_in)>a)=NaN; 
% u_in=(3*epsilon0)/(epsilon1+2*epsilon0)*E0.*r_in.*cos(theta);  %球内的电位
% u_out=(E0.*r_out+(epsilon0-epsilon1)/(epsilon1+2*epsilon0)*E0*a^3./r_out.^2).*cos(theta); %球外的电位
% [Ey_in,Ez_in]=gradient(-u_in,hy,hz);      %计算球内的电场
% [Ey_out,Ez_out]=gradient(-u_out,hy,hz);   %计算球外的电场
% figure;
% quiver(y,z,Ey_out,Ez_out,'b');
% hold on;
% Sy = a * cos(0:0.01*pi:2*pi);
% Sz = a * sin(0:0.01*pi:2*pi);
% patch(Sy, Sz, [0.8 0.8 0.8], 'EdgeColor', 'b', 'LineWidth', 1.5);
% quiver(y,z,Ey_in,Ez_in,0.5,'b');
% axis equal
% title('介质球附近的电场');