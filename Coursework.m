[y, fs] = audioread('corrupt1718.m4a');
[y1, fs] = audioread('H64DSP1718.m4a');
% yfft = fft(y);
y1(:,2) = [];
y1fft = fft(y1);
% yRfft = abs(yfft);
y1Rfft = abs(y1fft);
N =length(y);
p_last = 0.05;
% Q = 0.75;
R = 0.005;
x_last =0.1;
for i = 1: N
    f(i,1) = ((i-1)*fs)/N ;
    error(i,:) = y(i)- y1(i);
end
% Q = std(error,1,1);
% for i = 251: 256
%     y(i,1) = 0;
% end
% subplot(2,1,1);plot(f(1:(N+1)/2),y1Rfft(1:(N+1)/2));
% set(gca,'xtick',[0:1000:N]);
% subplot(2,1,2);plot(f(1:(N+1)/2),yRfft(1:(N+1)/2));
% yf1 = medfilt1(y,5);
% fc =1200hz
% subplot(3,1,1);
% plot(y);
process1 = medfilt1(y,7);
% subplot(3,1,2);
%  plot(process1);
%  subplot(3,1,3);
%  plot(y1);

% % % kalmanfilter

% for k = 1:N
%    x_mid = x_last;
%    p_mid = p_last + Q;
%    kg = p_mid/(p_mid+Q);
%    x_now = x_mid+ kg*(y(k)- x_mid);
%    p_now = (1-kg)*p_mid;
%    x_last = x_now;
%    X(k,:) = x_now;
% end
%   subplot(2,1,1);plot(X);
%   subplot(2,1,2);plot(process1);

% process1fft = abs(fft(process1));
% subplot(2,1,2);plot(f(1:(N+1)/2),process1fft(1:(N+1)/2));
% subplot(2,1,1);plot(f(1:(N+1)/2),y1Rfft(1:(N+1)/2));


