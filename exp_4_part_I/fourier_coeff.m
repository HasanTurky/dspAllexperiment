clc
clear all
close all

%% generating a pulse train
fs = 100e3; %sampling frequency
dt = 1/fs; % sampling period

T = 1e-3;  %period of the signal
pw = .1e-3; % pulsewidth of the signal
t = -T/2 : dt : T/2; % sampling time array
n = t/dt;                % sample index
L = pw/dt;             % number of samples in a pulse
x = zeros(1,length(t));   % initiating the pulse
x(find(abs(n)<=L/2))=1.1; %creating the pulse 
subplot(211)
plot(t,x,'linewidth',3);      %continuous pulse
subplot(212)
stem(n,x,'linewidth',2); % discrete time pulse

%% calculation of fourier coefficient
N = length(x);

if(N/2 == 0)
    k = -2*N:2*N-1;
else
    k = -2*(N-1):2*(N-1);
end
c = zeros(1,length(k));
for i = 1 : length(k)
    for i1 = 1 : length(x)
        c(i) = c(i) + x(i1)*exp(-j*2*pi*k(i)*n(i1)/N);
    end
    c(i) = c(i)/N;
end

mag = abs(c);
subplot(321),stem(k,mag,'linewidth',.6),title('Magnitude');
phase = angle(c)*180/pi;
subplot(322),stem(k,phase,'linewidth',.6),title('phase');
subplot(323), stem(k*1/T, c, 'linewidth',.6),title('c vs freq');
subplot(324),stem(k,mag.^2,'linewidth',.6),title('power density');

