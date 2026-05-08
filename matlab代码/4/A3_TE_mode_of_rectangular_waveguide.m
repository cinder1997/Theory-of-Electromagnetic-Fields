%% 绘制矩形波导中的TE_mn模式
clear;clc;close all;
a=109.22e-3;  %矩形波导的宽,单位m
b=54.61e-3;   %矩形波导的高,单位m
c=300e-3;     %矩形波导的长,单位m
m=1;          %模式
n=0;
f=2e9;        %信号频率
w=2*pi*f;
T=1/f;
mu0=4*pi*1e-7;
epsilon0=8.854e-12;
kx=m*pi/a;
ky=n*pi/b;
kc=sqrt(kx^2+ky^2);
k=sqrt(w^2*mu0*epsilon0);
beta=sqrt(k^2-kc^2); %波数
fc=kc/(2*pi*sqrt(mu0*epsilon0)) %截止频率
if f<fc
    error('信号频率小于截止频率，无法传输');
end

t=0:0.1*T:5*T;     %时间步长
[x,y,z]=meshgrid(linspace(0,a,10),linspace(0,b,10),linspace(0,c,20)); %空间网格
Ex = cell(1, length(t));Ey = cell(1, length(t));Ez = cell(1, length(t));
Hx = cell(1, length(t));Hy = cell(1, length(t));Hz = cell(1, length(t));
for i=1:1:length(t)
    Ex{i}=w*mu0/kc^2*ky.*cos(kx.*x).*sin(ky.*y).*cos(w*t(i)-beta.*z+pi/2);
    Ey{i}=-w*mu0/kc^2*kx.*sin(kx.*x).*cos(ky.*y).*cos(w*t(i)-beta.*z+pi/2);
    Ez{i}=zeros(size(Ex{i}));
    Hx{i}=beta/kc^2*kx.*sin(kx.*x).*cos(ky*y).*cos(w*t(i)-beta.*z+pi/2);
    Hy{i}=beta/kc^2*ky.*cos(kx.*x).*sin(ky*y).*cos(w*t(i)-beta.*z+pi/2);
    Hz{i}=cos(kx.*x).*cos(ky*y).*cos(w*t(i)-beta.*z);
end

figure;
for i=1:1:length(t)
    quiver3(z,x,y,Ez{i},Ex{i},Ey{i},'blue');   %绘制电场，这里交换坐标顺序，便于更好观看
    hold on;
    quiver3(z,x,y,Hz{i},Hx{i},Hy{i},'red');    %绘制磁场
    hold off;
    axis equal
    set(gca, 'YDir', 'reverse');
    legend('E','H');
    xlabel('z');ylabel('x');zlabel('y');
    title(sprintf('矩形波导的TE%d%d模式,t=%.2d秒',m,n,t(i)));
    pause(0.1);
end