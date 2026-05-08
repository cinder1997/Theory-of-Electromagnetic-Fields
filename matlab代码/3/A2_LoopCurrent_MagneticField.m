%% 真空中圆环电流的磁场
clear;clc;close all;
I=1;               %电流大小
a=1;               %半径
mu0=4*pi*1e-7;
[x, y, z] = meshgrid(linspace(-2,2,20),linspace(-2,2,20), linspace(-0.5,0.5,10)); % 创建网格
hx=x(1,2,1)-x(1,1,1);hy=y(2,1,1)-y(1,1,1);hz=z(1,1,2)-z(1,1,1);
r=sqrt(x.^2+y.^2+z.^2);
phi=atan2(y,x);
k=sqrt(4*a.*r./((a+r).^2+z.^2));
A=mu0*I*a/pi./k.*sqrt(a./r).*( (1-k.^2/2).*ellipticK(k)-ellipticE(k) );
Ax=A.*-sin(phi);
Ay=A.*cos(phi);
Az=zeros(size(A));
[Bx,By,Bz]=curl(x,y,z,Ax,Ay,Az);    %数值方法计算磁矢位的旋度，即磁场

figure;
loop_x=a.*cos(linspace(0,2*pi,30));
loop_y=a.*sin(linspace(0,2*pi,30));
loop_z=0.*linspace(0,2*pi,30);
plot3(loop_x,loop_y,loop_z,'r','LineWidth',2); %绘制圆环电流
hold on;
quiver3(x, y, z, Bx, By, Bz);                  %绘制磁场
axis equal;
xlabel('x');ylabel('y');zlabel('z');
title('真空中圆环电流的磁场');
figure;
plot(a,0, 'r.', 'MarkerSize', 20, 'LineWidth', 2);
hold on
plot(-a,0, 'r.', 'MarkerSize', 20, 'LineWidth', 2);
y_length=size(y);y_mid=ceil(y_length(1)/2);
quiver(x(y_mid,:,:), z(y_mid,:,:), Bx(y_mid,:,:), Bz(y_mid,:,:),'r');
axis equal;
title('真空中圆环电流的磁场—XOZ平面');