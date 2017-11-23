% ϵͳ��ʶ
clc ; clear ; close all;

x = normrnd(0,1,1,500); % input x(n)
b = fir1(31,0.05);      % fir filter coeff
d = filter(b,1,x);      % output d(n)

figure;    freqz(b);    title('δ֪ϵͳ��Ƶ/��Ƶ����')
figure;    plot(abs(fftshift(fft(x))));    title('�����ź�x(n)')
figure;    plot(abs(fftshift(fft(d))));    title('δ֪ϵͳ���d(n)')

x_in = zeros(32,500); % delay  0 to 31    filter order = 31
for k = 1:1:32
    x_in(k,:) = [zeros(1,k-1)  x(1:500-k+1)];
end

R_xx = x_in*x_in'/500;
R_dx = d*x_in'/500;
w = inv(R_xx)*R_dx.';
y = w'*x_in;

figure;    plot(abs(fftshift(fft(y))));  title('ά���˲�������ź�Ƶ��')
figure;    freqz(w);    title('ά���˲�����Ƶ/��Ƶ����')