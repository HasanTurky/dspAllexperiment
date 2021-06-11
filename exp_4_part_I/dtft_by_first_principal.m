clc
clear all
close all

M = 1000;% number of frequency
t =-1: 1/M: 1-1/M;
x = sinc(200*t)+sinc(2*pi*50*t).^2+sinc(240*t);
n = round(t*M);
fn = linspace(-1,1,length(x))*M/2;
y = fftshift(fft(x));
subplot(311), plot(fn,abs(y),'linewidth',1.5),grid on, grid minor,title('SPECTRUM BY FFT');


k = 0: M-1; % denotes frequency index
fk =linspace(-M/2,M/2,M);
nk = (n'*k) ;
wm = exp(-j*2*pi/M);
w = wm.^nk;%dtft matrix
% a = dftmtx(1000);
F = (x*w);
subplot(312),plot(fk,abs( fftshift(F)),'linewidth',1.5), grid on, grid minor,title('SPECTRUM BY MATRIX METHOD');


z = zeros(1,length(k));
for i1 = 1 : length(z)
    for i2 = 1 : length(x)
        z(i1) = z(i1) + x(i2) * exp(-j*k(i1)*2*pi*n(i2)/M);
    end
end
subplot(313), plot(fk, abs(fftshift(z)),'linewidth',1.5), grid on, grid minor, title('spectrum by first principle')
