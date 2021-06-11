clc
clear all
close all
%%
fs = 2.4e3;
T = 1/fs;
t =0:  T : 1/150;
n = t/T;
x_t = 3*sin(300*pi*t)-4*cos(900*pi*t)+cos(1200*pi*t);
subplot(311),plot(t,x_t);
x_n = 3*sin(2*pi*150/2.4e3*n)-4*cos(2*450*pi/2.4e3*n)+cos(2*600*pi/2.4e3*n);
subplot(312),stem(n,x_n,'linewidth',1.3);

N = length(x_n);
c = zeros(1,N);
if(N/2 == 0)
    k = -N/2:N/2-1;
else
    k = -(N-1)/2:(N-1)/2;
end
for i = 1 : N;
    for i1 = 1 : N;
        c(i) = c(i) + x_n(i1)*exp(-j*2*pi*k(i)*n(i1)/N);
    end
    c(i) = c(i)/N;
end
% mag = abs(c);
% subplot(311),stem(n,mag);
% grid on;
% grid minor;
% ang = angle(c);
% subplot(312), stem(n,ang);
% grid on;
% grid minor;
% subplot(313), stem(n*150,c)
% grid on;
% grid minor;

x_re = zeros(1,length(n));
for i = 1:N
    for i1 = 1:N
        x_re(i1) = x_re(i1) + c(i)*exp(j*2*pi*k(i)*n(i1)/N);
    end
end
subplot(313), plot(t,x_re);

