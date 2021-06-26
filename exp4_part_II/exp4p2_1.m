clc;
clear all;
close all;
n=64;
N = 500;
t=125e-6;
f=1/t;
t1=t*(0:n-1);
fn = (0:1/N:1-1/N)*f-f/2;
x=sin(2*pi*1062.5*t1)+0.05*sin(2*pi*1625*t1);
figure(1)
subplot(221),stem(0:n-1,x),title('Data sequence')
subplot(223),stem(fn,abs(fftshift(fft(x,N)))),title('Magnitude spectrum')
wind=hann(64);
x1=wind'.* x;
subplot(222),stem(0:n-1,x1),title('Data sequence after windowing')
subplot(224),stem(fn,abs(fftshift(fft(x1,N))))
title('Magnitude spectrum after windowing')
