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
% Q = std(error,1,1);

% subplot(2,1,1);plot(f(1:(N+1)/2),y1Rfft(1:(N+1)/2));
% set(gca,'xtick',[0:1000:N]);
% subplot(2,1,2);plot(f(1:(N+1)/2),yRfft(1:(N+1)/2));
% yf1 = medfilt1(y,5);
% fc =1200hz
% subplot(3,1,1);
% plot(y);
process1 = medfilt1(y,5);
% subplot(3,1,2);
%  plot(process1);
%  subplot(3,1,3);
%  plot(y1);

% % % kalmanfilter



% process1fft = abs(fft(process1));
% subplot(2,1,2);plot(f(1:(N+1)/2),process1fft(1:(N+1)/2));
% subplot(2,1,1);plot(f(1:(N+1)/2),y1Rfft(1:(N+1)/2));
% Wn1 = roundn((1000*2)/48000,-5);
% h1 = fir1( 50, Wn1,'low');
% process2 = filter(h1, 1, process1);
%  subplot(2,1,2);plot(process2);
Wn2 = [roundn((980*2)/48000,-5),roundn((1020*2)/48000,-5)];
order3 = 15000;
h2 = fir1( order3, Wn2,'stop');

Wn3 = [roundn((1980*2)/48000,-5),roundn((2020*2)/48000,-5)];
h3 = fir1( order3, Wn3,'stop');
process3 = filter(h2, 1, process1);
process4 = filter(h3, 1, process3);
Wn4 = roundn((1100*2)/48000,-5);
order = 40;
h4 = fir1( order, Wn4,'low');
process5 = filter(h4, 1, process4);
Wn5= roundn((50*2)/48000,-5);
order5 = 900;
h5 = fir1( order5, Wn5,'high');
process6 = filter(h5, 1, process5);
order6 = 100;
Wn6= [roundn((1300*2)/48000,-5),roundn((2000*2)/48000,-5)];
h6 = fir1( order6, Wn6,'stop');
process7 = filter(h6, 1, process6);
order7 = 200;
Wn7= [roundn((750*2)/48000,-5),roundn((1300*2)/48000,-5)];
h7 = fir1( order7, Wn7,'stop');
process8 = filter(h7, 1, process7);
% 
% % figure; freqz(h4,1);


for i = (order3 + order/2) : N
    error(i +1 -(order3 + order/2),:) = process5(i) - y1(i +1 -(order3 + order/2));
end

process9 = medfilt1(process8,9);

% errorfft   = abs(fft(error));
% Xfft = abs(fft(process9));
% subplot(5,1,1);plot(process8);
% subplot(5,1,2);plot(process9);
% subplot(5,1,3);plot(y1);
% subplot(5,1,4);plot(f(1:(N+1)/2),Xfft(1:(N+1)/2));
% subplot(5,1,5);plot(f(1:(N+1)/2),y1Rfft(1:(N+1)/2));
% sound(process9,fs);
% figure ; freqz(heroor);
% figure;freqz(h6,1);
% sound(process8,fs);
%  figure; freqz(h1,1);
% %    freqz(h3,1);
% process6 = medfilt1(process5,9);

% for i = 1: (N-130000)
%   
%     error(i,:) = process5(i)- y1(i+13000);
% end



% 
% p_last = 0;
% % Q = 0.75;
% R = 100;
% Q = 0.5;
% x_last =0;
% for k = 1:N
%    x_mid = x_last;
%    p_mid = p_last + Q;
%    kg = p_mid/(p_mid+R);
%    x_now = x_mid+ kg*(process8(k)- x_mid);
%    p_now = (1-kg)*p_mid;
%    x_last = x_now;
%    X(k,:) = x_now;
% end

% plot(delat);


subplot(3,1,1);plot(process8);
subplot(3,1,2);plot(X);
subplot(3,1,3);plot(y1);
sound(X,fs);
% % yfft = abs(fft(y));
% % Nfft = yfft - Xfft;
% % Hfft =  abs((Xfft.^Xfft) ./ (Nfft.^Nfft + Xfft.^Xfft) );
% 
% 
% % plot(Hfft);
% % for i = 1: (N-130000)
% 
% % % plot(Ds);
% % end
% 
% % yfftt = fft(y);
% % Ds = Hfft .* yfftt;
% % designal = ifft(Ds);
% % figure;plot(designal);


% sound(process5,fs);
% sound(y1,fs);
% audiowrite('processed1.m4a',X,fs);
% audiowrite('processed2.m4a',process5,fs);
% sound(process5,fs);