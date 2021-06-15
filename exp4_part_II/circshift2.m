function [y , x] = circshift2(x, m, N)
% x is the vector containing signal
% m is the number of sample we want to shift
% N is the number of point in the signal
% y is the shifted signal 

x = [x zeros(1, N-length(x))] ;
n = 0 : N-1;
n = mod(n-m,N);
y = x(n+1);

end
