[y, fs] = audioread('corrupt1718.m4a');
[y1, fs] = audioread('H64DSP1718.m4a');
yfft = fft(y);
y1fft = fft(y1);
yRfft = abs(yfft);
y1Rfft = abs(y1fft);
N = 245759;
for i = 1: N
    f(i,1) = ((i-1)*fs)/N ;
end