%% MATLAB数值方法与解析方法的差异
clc;clear;close all;
x=linspace(0,6*pi,100);
hx=x(2)-x(1);

y=sin(x);
y1=cos(x);      %解析梯度
y2=gradient(y); %数值梯度
y3=gradient(y,hx); %指定步长的数值梯度
plot(x,y1,'r',x,y2,'g',x,y3,'b');
legend('解析梯度','数值梯度','指定步长的数值梯度'); %为了保证准确性，使用数值梯度时应指定x、y方向上的步长