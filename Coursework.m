[y, fs] = audioread('corrupt1718.m4a');
[y1, fs] = audioread('H64DSP1718.m4a');
% yfft = fft(y);
y1(:,2) = [];
y1fft = fft(y1);
% yRfft = abs(yfft);
y1Rfft = abs(y1fft);
N =length(y);
for i = 1: N
    f(i,1) = ((i-1)*fs)/N ;
end
for i = 251: 256
    y(i,1) = 0;
end
subplot(2,1,1);plot(f(1:(N+1)/2),y1Rfft(1:(N+1)/2));
% set(gca,'xtick',[0:1000:N]);
% subplot(2,1,2);plot(f(1:(N+1)/2),yRfft(1:(N+1)/2));
yf1 = medfilt1(y,5);
% fc =1200hz
[B A] = butter(6 ,2000*2/48000, 'low');
[H F] = freqz (B, A, 512);
%  plot(F,abs(H));
yf2 = filter(B,A,yf1);
yf3 = medfilt1(yf2,5);
yf2fft = fft(y4);
yRf2 = abs(yf2fft);
subplot(2,1,2);plot(f(1:(N+1)/2),yRf2(1:(N+1)/2));

