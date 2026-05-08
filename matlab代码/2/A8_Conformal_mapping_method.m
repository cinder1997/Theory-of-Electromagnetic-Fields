%% 使用保角变换法计算扇形区域内的电位
clear;clc;close all;
theta=pi/3;  %扇形角度
a=1;         %内半径
b=2;         %外半径
ln_ba=log(b/a);
V0=1;        %上导体平板的电位
[x,y]=meshgrid(linspace(0,b,100),linspace(0,b,100));
hx=x(1,2)-x(1,1);hy=y(2,1)-y(1,1);
angle=atan2(y,x);
angle(angle>theta)=NaN;
r=sqrt(x.^2+y.^2);
r(r<a | r>b)=NaN;
coef=angle.*r;
coef(~isnan(coef))=1;  %系数矩阵，从矩形区域中截出扇形区域

for n=1:3
    Cn=2*V0*(1-cos(n*pi))/( pi*n*sinh(n*pi*theta/ln_ba) );%各个模式的展开系数
    phi=coef.*Cn.*sinh(n*pi.*atan2(y,x)/ln_ba).*sin(n*pi.*( log(sqrt(x.^2+y.^2))-log(a) )/ln_ba);         %各个模式的电位
    [Ex,Ey]=gradient(-phi,hx,hy);                          %数值梯度计算电场
    figure;
    contour(x,y,phi,'fill','on');
    hold on;
    quiver(x,y,Ex,Ey);
    title(sprintf('模式n=%d 时的电场，该模式的系数为%f', n,Cn));
end