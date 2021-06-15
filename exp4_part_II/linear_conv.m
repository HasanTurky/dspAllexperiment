clc
clear all
close all

h = [1 2 3];
x = [1 2 2 1];
L = length(x);
M = length(h);
N = L+M-1;
x_pad = [x zeros(1,M-1)];
h_pad = [h zeros(1,L-1)];
n = 0 : N-1;
%% using matrix method
A = zeros(N,M);
% row of convmtx will be equal to N
% colom will be equal to original impulse length
% the message signal should be circulary shifted and inserted in each
% colomn of convmtx
for i = 1 : M
    A( : ,i ) = circshift2(x,i-1,N);
end
result_mat = A*h';
subplot(211), stem(n,result_mat,'linewidth',3),title("result by matrix method")

%% using dft


