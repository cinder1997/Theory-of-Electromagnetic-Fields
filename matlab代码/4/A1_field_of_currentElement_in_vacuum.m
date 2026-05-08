%% 绘制真空中电流元的辐射场（格林函数法）
clear;clc;close all;
Im=1;          %电流元的幅度
f=1e9;         %电流元的频率
w=2*pi*f;   
T=1/f;
mu0=4*pi*1e-7;
epsilon0=8.854e-12;
c=1/sqrt(mu0*epsilon0);

[x, y, z] = meshgrid(linspace(-T*c,T*c,20),linspace(-T*c,T*c,20), linspace(-T*c,T*c,20)); % 创建空间网格
hx=x(1,2,1)-x(1,1,1);hy=y(2,1,1)-y(1,1,1);hz=z(1,1,2)-z(1,1,1);
r=sqrt(x.^2+y.^2+z.^2);
theta=atan2(sqrt(x.^2+y.^2),z);
phi=atan2(y,z);
t=0:0.1*T:5*T;     %时间和步长
Jx=zeros(1,length(t));Jy=zeros(1,length(t));Jz=zeros(1,length(t));
Ax = cell(1, length(t));Ay = cell(1, length(t));Az = cell(1, length(t));
Bx = cell(1, length(t));By = cell(1, length(t));Bz = cell(1, length(t));
Er = cell(1, length(t));Etheta = cell(1, length(t));Ephi = cell(1, length(t));
Ex = cell(1, length(t));Ey = cell(1, length(t));Ez = cell(1, length(t));
for i=1:1:length(t)
Jx(i)=0;Jy(i)=0;Jz(i)=Im*cos(w*t(i));       %计算电流元
Ax{i}=zeros(size(x));
Ay{i}=zeros(size(y));
Az{i}=mu0*Im/(4*pi.*r).*cos(w.*(t(i)-r/c)); %计算磁矢位
[Bx{i},By{i},Bz{i}]=curl(x,y,z,Ax{i},Ay{i},Az{i});    %数值方法计算磁矢位的旋度,得到磁场
k=w/c;
Er{i}=Im*k^3.*cos(theta)./(2*pi*w*epsilon0).*( 1./(k.*r).^2.*cos(w.*(t(i)-r/c))-1./(k.*r).^3.*cos(w.*(t(i)-r/c)+pi/2) ); %计算电场
Etheta{i}=Im*k^3.*sin(theta)./(4*pi*w*epsilon0).*( 1./(k.*r).*cos(w.*(t(i)-r/c)+pi/2)+1./(k.*r).^2.*cos(w.*(t(i)-r/c))-1./(k.*r).^3.*cos(w.*(t(i)-r/c)+pi/2)  );
Ephi{i}=zeros(size(Er{i}));
[X, Y, Z, Ex{i}, Ey{i}, Ez{i}] = sph2cart(r, theta, phi, Er{i}, Etheta{i}, Ephi{i});
end

figure;
for i=1:1:length(t)
    quiver3(0,0,0,Jx(i),Jy(i),1e-1*Jz(i),'red','LineWidth',2);  %绘制电流元
    hold on;
    quiver3(x,y,z,Ax{i},Ay{i},Az{i},'color',"#0072BD");      %绘制磁矢位
    hold off;
    axis equal
    title(sprintf('电流元的磁矢位,t=%.2d秒',t(i)));
    pause(0.1);
end
figure;
for i=1:1:length(t)
    quiver3(0,0,0,Jx(i),Jy(i),1e-1*Jz(i),'red','LineWidth',2);  %绘制电流元
    hold on;
    quiver3(x,y,z,Bx{i},By{i},Bz{i},'color',"#D95319");      %绘制磁矢位
    hold off;
    axis equal
    title(sprintf('电流元的磁场,t=%.2d秒',t(i)));
    pause(0.1);
end
figure;
for i=1:1:length(t)
    quiver3(0,0,0,Jx(i),Jy(i),1e-1*Jz(i),'red','LineWidth',2);  %绘制电流元
    hold on;
    quiver3(x,y,z,Ex{i},Ey{i},Ez{i},'color',"#4DBEEE");      %绘制电场
    hold off;
    axis equal
    title(sprintf('电流元的电场,t=%.2d秒',t(i)));
    pause(0.1);
end

% 查看工作区变量占用的总内存
% vars = whos;
% totalBytes = sum([vars.bytes]);
% totalMB = totalBytes / 1024^2;
% fprintf('工作区总内存占用: %.2f MB\n', totalMB);
