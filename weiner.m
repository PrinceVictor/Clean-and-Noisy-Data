% œµÕ≥±Ê ∂
clc ; clear ; 

% wienner filtering
[y, fs] = audioread('corrupt1718.m4a');
[y1, fs] = audioread('H64DSP1718.m4a');
y1(:,2) = [];
N =length(y);
for i = 1: N
    f(i,:) = ((i-1)*fs)/N ;  
    nosie(i,:) = y(i) - y1(i);
end
clc ; clear ; 
% figure; plot(y1);
% figure; plot(y);
% figure; plot(nosie);

% 
% nosiefft = abs(fft(nosie));
% yfft = abs(fft(y1));
% Hf = yfft.^2 ./ (yfft.^2 + nosiefft.^2);
% figure; plot(Hf);

sd = input(' Noise standard deviation: ');
mu = input(' mu: ');
ordr = input(' number of weights: ');

for i=1:1000
    d(i)=sin(2*pi*0.06*(i-1))+sd*randn;
    x(i)=2*cos(2*pi*0.06*(i-1));
end

W=zeros(1,ordr); % initialisation of weights to zero
e=zeros(1,length(x));
for k=ordr:length(x)    
    Xk=x(k-ordr+1:k);
    e(k)=d(k)-W*Xk';
    W=W+2*mu*e(k)*Xk;
end

% plot error signal

figure
plot(e,'k')
xlabel(' Sample Number')
ylabel(' Error d-y')

% Signal = ifft(Hf.* fft(y));
% figure; plot(Signal);
% figure; plot(y1);
% figure; plot(y);
% figure; plot(nosie);