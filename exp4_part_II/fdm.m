clc
clear all
close all
fs = 2000;
ts = 1/2000;
fc1 = 250;
fc2 = 750;
to = .1
t = -to : ts : to;
n = t/ts;
N = 1024;
fn = [0 : 1/N : 1 - 1/N] * fs - fs/2;
m1 = sinc(100*t);
m2 = sinc(100*t).^2;
c1  = cos(2*pi*fc1*t);
c2 = cos(2*pi*fc2*t);
%%  message and carrier
figure(1)
subplot(221),plot(fn,abs(fftshift(fft(m1,1024))),'linewidth',3),title("Message Signal 1");
subplot(222),plot(fn,abs(fftshift(fft(c1,1024))),'linewidth',3),title("Carrier Signals 1");
subplot(223),plot(fn,abs(fftshift(fft(m2,1024))),'linewidth',3),title("Message Signal 2");
subplot(224),plot(fn,abs(fftshift(fft(c2,1024))),'linewidth',3),title("Carrier Signals 2");
%%  modulation and fdm
u1 = m1 .* c1;
u2 = m2.*c2;
u = u1 + u2;

M1 = fftshift(fft(m1,1024));
M2 = fftshift(fft(m2,1024));

U1 = fftshift(fft(u1,1024));
U2 = fftshift(fft(u2,1024));
U = fftshift(fft(u,1024));
figure(2)
subplot(311),plot(fn, abs(U1),'linewidth',3),grid on,grid minor,title("modulated signal 1");
subplot(312),plot(fn,abs(U2),'linewidth',3),grid on,grid minor,title("modulated signal 2");
subplot(313), plot(fn,abs(U),'linewidth',3),grid on,grid minor,title("FDM signal");
%% bandpass
bpf1 = bandpass(u,[200 300],fs);

BPF1 = fftshift(fft(bpf1, 1024));
figure(3)
subplot(211),plot(fn,abs(BPF1),'linewidth',3),grid on, grid minor,title("bpf1 o/p");
bpf2 = bandpass(u,[650 850],fs);
BPF2 = fftshift(fft(bpf2, 1024));
subplot(212),plot(fn,abs(BPF2),'linewidth',3),grid on, grid minor,title("bpf2 o/p");
%% reconstruction process 
y1 = bpf1.*c1;
y2 = bpf2.*c2;
Y1 = fftshift(fft(y1,1024));
Y2 = fftshift(fft(y2,1024));
figure(4)
subplot(211), plot(fn,abs(Y1),'linewidth',3),title("siganl multiplied by carrier 1");
subplot(212), plot(fn,abs(Y2),'linewidth',3),title('signal multiplied by carrier 2');
%%  lowpass
m1_recon = lowpass(y1,150,2000);
M1_recon = fftshift(fft(m1_recon,1024));

m2_recon = lowpass(y2,150,2000);
M2_recon = fftshift(fft(m2_recon,1024));

figure(5)

subplot(211), plot(fn,abs(M1_recon),'linewidth',3),title("reconstructed signal 1");
subplot(212),plot(fn, abs(M2_recon),'linewidth',3),title("reconstructed signal 2");