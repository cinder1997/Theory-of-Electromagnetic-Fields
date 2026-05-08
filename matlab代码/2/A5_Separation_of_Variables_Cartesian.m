%% 直角坐标系下使用分离变量法计算矩形区域内的电位和电场
clear;clc;close all;
a=2;b=1;                 %矩形区域的长宽
V0=1;                    %上导体平板的电位
[x,y]=meshgrid(linspace(0,a,20),linspace(0,b,20));
hx=x(1,2)-x(1,1);hy=y(2,1)-y(1,1);
for n=1:5
    Cn=2*V0*(1-cos(n*pi))/( pi*n*sinh(n*pi*b/a) )    %各个模式的展开系数
    phi=Cn.*sinh(n*pi.*y/a).*sin(n*pi.*x/a);         %各个模式的电位
    [Ex,Ey]=gradient(-phi,hx,hy);                          %数值梯度计算电场
    figure;
    contour(x,y,phi,'fill','on');
    hold on;
    quiver(x,y,Ex,Ey);
    title(sprintf('模式n=%d 时的电场，该模式的系数为%f', n,Cn));
end