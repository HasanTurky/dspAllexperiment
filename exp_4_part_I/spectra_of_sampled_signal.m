clc
clear all
close all
BW = 100;
q = [1 1.25 2 4 5 6 7 8] ;
s = 1;
% q = [ 2 ];
for l = 1 : length(q) 
    fs = q(l)*BW;
    t_o = .13;
    ts = 1/fs;
    n = -round(t_o/ts) : round(t_o/ts);
    t = n*ts ;
    m = [ sinc(200*t) ];
    N = 1024;
    L = length(m);
    k = 0:5*N-1;
    fn = [0:1/N:5-1/N]*fs-5*fs/2;
    wn = exp(-j*2*pi/N);
    nk = n' * k;
    w = wn .^ nk;
    M = m*w;
    subplot(length(q),2,s),plot(fn,abs(fftshift(M)),0,0,'linewidth',1.5),grid on,grid minor,title(sprintf("%dBW",q(l)));
    s = s+1;
    subplot(length(q),2,s), stem(t,m,'linewidth',1.5),title(sprintf("sampled signal with FS = %dHz",fs));
    s = s+1;
end