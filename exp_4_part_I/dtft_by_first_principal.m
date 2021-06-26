clc
clear all
close all

M = 1000;   % number of frequency between [-pi,pi]
k = 0: M-1; % denotes frequency index
fs = 2000;  % sampling frequency of continuous signal
t =-.1 : 1/fs :.1-1/fs ;
x = sinc(200*t);
% +sinc(2*pi*50*t).^2+sinc(240*t);
subplot(411),plot(t,x,'linewidth',3),title('main signal');
n = round(t*fs); %time index
fk =linspace(-pi ,pi , M); %digital frequency grid

z = zeros(1,M); %frequency component matrix
for i1 = 1 : length(z)
    for i2 = 1 : length(x)
        z(i1) = z(i1) + x(i2) * exp(-j*n(i2)*fk(i1));
    end
end
subplot(412), plot(fk, abs((z)),'linewidth',1.5), grid on, grid minor, title('spectrum by first principle');

nk = (n'*k) ;
wm = exp(-j*2*pi/M);
w = wm.^nk;%dtft matrix
% a = dftmtx(1000);
F = (x*w);
subplot(413),plot(fk,abs( fftshift(F)),'linewidth',1.5), grid on, grid minor,title('SPECTRUM BY MATRIX METHOD');

dfk = fk(2)-fk(1);
n_re = -500:500;
x_re = zeros(1,length(n_re));
for i = 1 : length(x_re)
    x_re(i) = sum(exp(j*fk.*n_re(i)).*z*dfk)/(2*pi);
end
subplot(414),plot(n_re,(x_re),'linewidth',3),title('Reconstructed Signal');