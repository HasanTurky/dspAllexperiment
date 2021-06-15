clc
clear all
close all

N = 51;
x1 = rand(1,N);
n = 0 : N-1;
x2 = sin(2*pi*1000*n/10000);
x = x1+x2;
x_pad = [x1 + x2 zeros(1,length(n)-1)];
X = fft(x_pad);
Xconj = conj(X);
acf_X = fftshift(ifft(X.*Xconj));
samp = -n(end):n(end);
subplot(411),stem(n,x,'linewidth',3),grid on, grid minor,title('Original Signal');
subplot(412),stem(samp,fftshift(X.*Xconj),'linewidth',3),grid on, grid minor,title("Power Spectral Density ");
subplot(413),stem(samp,acf_X,'linewidth',3),grid on, grid minor,title("ACF from PSD");
subplot(414),stem(samp,xcorr(x),'linewidth',3),grid on, grid minor,title("ACF from time domain calculation");