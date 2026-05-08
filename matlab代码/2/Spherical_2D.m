%% 绘制YOZ平面图
a=1;                 %导体球的半径
E0=1;                %球外电场大小
[y, z] = meshgrid(linspace(-1.5,1.5,20), linspace(-1.5,1.5,20)); % 创建网格
hy=y(1,2)-y(1,1);hz=z(2,1)-z(1,1);
r=sqrt(y.^2+z.^2);
theta=atan2(sqrt(y.^2),z);

r(abs(r)<a)=NaN;                       %不计算导体球内部的电位
u_out=E0.*(r-a^3./r.^2).*cos(theta);   %球外空间的电位
[Ey,Ez]=gradient(-u_out,hy,hz);        %数值方法计算电位的梯度，即电场
figure;
quiver(y,z,Ey,Ez,0.6,'blue');
hold on;
Sy = a * cos(0:0.01*pi:2*pi);
Sz = a * sin(0:0.01*pi:2*pi);
plot(Sy, Sz,'r','LineWidth',2);
axis equal
title('导体球附近的电场');


a=1;                 %介质球的半径
E0=1;                %球外电场大小
epsilon0=8.854e-12;
epsilon1=10*epsilon0;
[y, z] = meshgrid(linspace(-1.5,1.5,20), linspace(-1.5,1.5,20)); % 创建网格
hy=y(1,2)-y(1,1);hz=z(2,1)-z(1,1);
r=sqrt(y.^2+z.^2);
theta=atan2(sqrt(y.^2),z);

r_out=r;r_in=r;
r_out(abs(r_out)<a)=NaN;    
r_in(abs(r_in)>a)=NaN; 
u_in=(3*epsilon0)/(epsilon1+2*epsilon0)*E0.*r_in.*cos(theta);  %球内的电位
u_out=(E0.*r_out+(epsilon0-epsilon1)/(epsilon1+2*epsilon0)*E0*a^3./r_out.^2).*cos(theta); %球外的电位
[Ey_in,Ez_in]=gradient(-u_in,hy,hz);      %计算球内的电场
[Ey_out,Ez_out]=gradient(-u_out,hy,hz);  %计算球外的电场
figure;
quiver(y,z,Ey_in,Ez_in,0.6,'b');
hold on;
quiver(y,z,Ey_out,Ez_out,0.6,'b');
hold on;
hold on;
Sy = a * cos(0:0.01*pi:2*pi);
Sz = a * sin(0:0.01*pi:2*pi);
plot(Sy, Sz,'b','LineWidth',2);
axis equal
title('介质球附近的电场');