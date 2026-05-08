%% 计算矢量函数的旋度
clear;clc;close all;
[x,y,z]=meshgrid(linspace(-2,2,20));
r=sqrt(x.^2+y.^2);
phi=atan2(y,x);
Ax=-sin(phi)./r;
Ax(:,:,1:9)=0;Ax(:,:,11:20)=0;
Ay=cos(phi)./r;
Ay(:,:,1:9)=0;Ay(:,:,11:20)=0;
Az=z.*0;
figure;
quiver3(x,y,z,Ax,Ay,Az,'LineWidth',1);       %绘制三维矢量场
xlim([-0.8 0.8]);ylim([-0.8 0.8]);zlim([-0.8 0.8]);
title("矢量场")

[curlx,curly,curlz]=curl(x,y,z,Ax,Ay,Az);    %数值方法计算矢量场的旋度
curlx(:,:,1:9)=0;curlx(:,:,11:20)=0;
curly(:,:,1:9)=0;curly(:,:,11:20)=0;
curlz(:,:,1:9)=0;curlz(:,:,11:20)=0;
figure;
quiver3(x,y,z,curlx,curly,curlz,'r','LineWidth',1);
xlim([-0.8 0.8]);ylim([-0.8 0.8]);zlim([-0.8 0.8]);
title("矢量场的旋度")

syms x y z;
r=sqrt(x.^2+y.^2);
phi=atan2(y,x);
A=[-sin(phi)/r,cos(phi)/r,0];
A_curl=curl(A,[x,y,z])                       %解析方法计算矢量场的旋度