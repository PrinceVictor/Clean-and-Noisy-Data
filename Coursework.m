%Read the data from the file corrupt1718.m4a
[corruptsignal, fs] = audioread('corrupt1718.m4a');
N =length(corruptsignal);                     %get the length of the corrputsignal 
[cleansignal, fs] = audioread('H64DSP1718.m4a');
cleansignal(:,2) = [];

% f is frequency correspond to each point
for p = 1:N
    t(p,1) = p/fs;
    f(p,1) = ((p-1)*fs)/N ;  
end

% Median Filter
processed = medfilt1(corruptsignal,5);
% figure;
% subplot(3,1,1);plot(corruptsignal);
% title('corruptsignal');
% subplot(3,1,2);plot(processed);
% title('Siganl processed by Median filter');
% subplot(3,1,3);plot(cleansignal);
% title('cleansignal');

% FIR filter
% FIR bandstop1 filter
order1 = 3000;                                  %order is 3000
% %frequency from 980hz to 1020hz
Wn1 = [roundn((980*2)/48000,-5),roundn((1020*2)/48000,-5)];       
h1 = fir1( order1, Wn1,'stop');
processed1 = filtfilt(h1, 1, processed);
% FIR bandstop2 filter
order2 = 3000;                                  %order is 3000
% %frequency from 1980hz to 2020hz
Wn2 = [roundn((1980*2)/48000,-5),roundn((2020*2)/48000,-5)];       
h2 = fir1( order2, Wn2,'stop');
processed2 = filtfilt(h2, 1, processed1);

% % IIR filter  
% % if want to run by IIR filter, please comment the FIR bandstop filter above 
% % IIR filter bandstop1
% % frequency from 980hz to 1020hz
% Wn2 = [roundn((980*2)/48000,-3),roundn((1020*2)/48000,-3)];        
% [B2, A2] = butter(3,Wn2,'stop');
% processed1 = filter(B2, A2, processed);
% % IIR filter bandstop2
% %frequency from 1980hz to 2020hz
% Wn3 = [roundn((1980*2)/48000,-3),roundn((2020*2)/48000,-3)];       
% [B3, A3] = butter(3,Wn3,'stop');
% processed2 = filter(B3, A3, processed1);

% FIR Low pass filter, 
order3 = 50;                                    %order is 50
Wn3 = roundn((2000*2)/48000,-5);                %cut off frequency at 2000hz
h3 = fir1( order3, Wn3,'low');
processed3 = filtfilt(h3, 1, processed2);

% figure;
% subplot(2,1,1);plot(processed3);
% title('Siganl processed by FIR filter');
% subplot(2,1,2);plot(cleansignal);
% title('cleansignal');


% Kalman Filter
x_last =0;
p_last = 0;
R  = 0.09;
Q  = 0.005;
kg = 0;
for k = 1:N
   x_mid = x_last;
   p_mid = p_last + Q;
   kg = p_mid/(p_mid+R);
   x_now = x_mid+ kg*(processed3(k)- x_mid);
   p_now = (1-kg)*p_mid;
   x_last = x_now;
   X(k,:) = x_now;
end
% figure;
% subplot(2,1,1);plot(X);
% title('Siganl processed by Kalman filter');
% subplot(2,1,2);plot(cleansignal);
% title('cleansignal');
% figure; plot(t,cleansignal,t,X);

% Wiener Filter
% Estimate the noise signal
noisesignal = X(1:53000);
for i = 1:3
noisesignal = [noisesignal ; zeros(40000,1)];
end
noisesignal = [noisesignal ;zeros(12000,1); X(185001:235000); X(1:10759)];

nosiefft = abs(fft(noisesignal));
UnderlySignal  = X - noisesignal;
sfft = abs(fft(UnderlySignal));
Hf = sfft.^2 ./ (sfft.^2 + nosiefft.^2);
Signal = ifft(Hf.* fft(X));
Signalfft = abs(fft(Signal));
figure;
subplot(2,1,1);plot(Signal);
title('Siganl processed by Kalman filter');
subplot(2,1,2);plot(cleansignal);
title('cleansignal');
figure; plot(t,cleansignal,t,Signal);

% % Adaptive Filter
% % Estimate the noise signal
% noisesignal2 = processed3(1:53000);
% for i = 1:3
% noisesignal2 = [noisesignal2 ; zeros(40000,1)];
% end
% noisesignal2 =[noisesignal2 ;zeros(12000,1); processed3(185001:235000); processed3(1:10759)];
% x = processed3 - noisesignal2;
% 
% mu = 0.0015;
% ordr = 4;
% W=zeros(1,ordr); % initialisation of weights to zero
% e=zeros(1,N);
% u = mean(x.^2);
% for k=ordr:N   
%     Xk=x(k-ordr+1:k);
%     yk(k) = W*Xk;
%     e(k)=processed3(k)-yk(k);
%     W=W+2*mu*e(k)*Xk';
% end
% subplot(2,1,1);plot(yk);
% title('Siganl processed by Adaptive filter');
% subplot(2,1,2);plot(cleansignal);
% title('cleansignal');
% figure; plot(t,cleansignal,t,yk);

% y1fft = fft(Cleansignal);
% y1Rfft = abs(y1fft)
corruptsignalfft = abs(fft(corruptsignal));
% subplot(2,1,1);plot(f(1:(N+1)/2),Signalfft(1:(N+1)/2));


