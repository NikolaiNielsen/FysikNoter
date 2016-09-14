clear all
close all
clc

C = 1;
L = 1;
omega0 = 1/sqrt(C*L);
R = [0.3*omega0*2*L, omega0*2*L, 3*omega0*2*L];
omega = sqrt(omega0^2-(R./(2*L)).^2);
t = (0:0.05:30);
e = 1;
lambda1 = (R(3)/(2*L)) + 1i*omega(3);
lambda2 = (R(3)/(2*L)) - 1i*omega(3);

I = zeros(3,length(t));
A = (-1/2 + 3/32 * sqrt(32))*1;
B = (-1/2 - 3/32 * sqrt(32))*0;

I(1,:) = sin(omega(1).*t).*exp(-t.*R(1)/(2*L));
I(2,:) = (0+t).*exp(-R(2).* t /(2*L));
I(3,:) = A.*exp(-lambda1.*t)+B*exp(-lambda2*t);

figure
hold on
plot(t,I(1,:))
plot(t,I(2,:))
plot(t,I(3,:))