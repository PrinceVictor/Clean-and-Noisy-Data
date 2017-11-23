% 系统辨识
clc ; clear ; close all;

x = normrnd(0,1,1,500); % input x(n)
b = fir1(31,0.05);      % fir filter coeff
d = filter(b,1,x);      % output d(n)

figure;    freqz(b);    title('未知系统幅频/相频特性')
figure;    plot(abs(fftshift(fft(x))));    title('输入信号x(n)')
figure;    plot(abs(fftshift(fft(d))));    title('未知系统输出d(n)')

x_in = zeros(32,500); % delay  0 to 31    filter order = 31
for k = 1:1:32
    x_in(k,:) = [zeros(1,k-1)  x(1:500-k+1)];
end

R_xx = x_in*x_in'/500;
R_dx = d*x_in'/500;
w = inv(R_xx)*R_dx.';
y = w'*x_in;

figure;    plot(abs(fftshift(fft(y))));  title('维纳滤波器输出信号频谱')
figure;    freqz(w);    title('维纳滤波器幅频/相频特性')