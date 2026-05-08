%% 绘制空气中的均匀平面波
clear;clc;close all;
f=1e9;         %频率
w=2*pi*f;  
mu0=4*pi*1e-7;
epsilon0=8.854e-12;
k=w*sqrt(mu0*epsilon0); %波数
Eta=sqrt(mu0/epsilon0); %波阻抗
lambda=2*pi/k; %波长
T=1/f;         %周期
Exm=1;         %电场X方向的幅度
Eym=0;         %电场Y方向的幅度
phix=0;        %电场X方向的初始相位
phiy=0;        %电场Y方向的初始相位

t=0:0.1*T:5*T;     %时间步长
z=linspace(0,5*lambda,120);x=zeros(size(z));y=zeros(size(z));      %空间网格
Ex = cell(1, length(t));Ey = cell(1, length(t));Ez = cell(1, length(t));
Hx = cell(1, length(t));Hy = cell(1, length(t));Hz = cell(1, length(t));
for i=1:1:length(t)
    Ex{i}=Exm.*cos(w*t(i)-k.*z+phix);
    Ey{i}=Eym.*cos(w*t(i)-k.*z+phiy);
    Ez{i}=zeros(size(Ex{i}));
    Hx{i}=-1/Eta*Eym.*cos(w*t(i)-k.*z+phiy);
    Hy{i}=1/Eta*Exm.*cos(w*t(i)-k.*z+phix);
    Hz{i}=zeros(size(Hx{i}));
end

figure;
for i=1:1:length(t)
    quiver3(y,z,x,Ey{i},Ez{i},Ex{i},'blue');   %绘制电场，这里交换坐标顺序，便于更好观看
    hold on;
    quiver3(y,z,x,Hy{i},Hz{i},Hx{i},'red');    %绘制磁场
    hold off;
    axis equal
    set(gca, 'YDir', 'reverse');
    legend('E','H');
    xlabel('y');ylabel('z');zlabel('x');
    title(sprintf('均匀平面电磁波,t=%.2d秒',t(i)));
    pause(0.1);
end