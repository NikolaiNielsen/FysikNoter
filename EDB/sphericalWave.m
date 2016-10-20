close all
clear all
clc
xampHigh = 4*pi;
xampLow = 2*pi/3;
x = linspace(-4*pi,4*pi,200);
wave = -3*sin(2*x)./x;
xampM = linspace(-xampHigh,-xampLow,70);
xampP = linspace(xampLow,xampHigh,70);
ampM = 3*abs(1./xampM);
ampP = 3*abs(1./xampP);

figure
hold on
plot(x,wave,'r')
plot(xampM,ampM,'--b')
plot(xampP,ampP,'--b')
hold off

%%
clear all
close all
clc

x = linspace(-4*pi,4*pi,200);
[x2,y2] = meshgrid(x,x);
r = sqrt(x2.^2+y2.^2);
z = 2*sin(2*r)./r;
surf(x2,y2,z); 
colormap jet; 
shading interp;