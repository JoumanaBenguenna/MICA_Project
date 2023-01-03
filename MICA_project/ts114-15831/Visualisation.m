%% Paramètres
clear;
close all;
clc;

%% Paramètre
d=50;
N=100;
N_fft=2^nextpow2(N);
w=hamming(N);
ecg=load('ecg_normal_1.mat');
x=ecg(1).ecg;
Fs=ecg(1).Fs;
% [X, f, t]=stft(x,w,d,N_fft,Fs);
[Sx, f, t]=spectro(x,w,d,N_fft,Fs);
spectre=Sx;

figure()
imagesc(t, f, 20*log10(Sx));
temps=(1:length(x))/Fs;
xlabel('Time in s')
ylabel('Frequency in Hz')
title('Spectrogram ecg')
color=colorbar;
colobar.label.string='intensity';
xx1=(1:1/Fs:length(x));


figure()
plot(xx1);
xlabel('Time in s')
ylabel('Amplitude')

%% partie 6


[indices_R] = QRS(x,Fs);

rc=zeros(1,length(indices_R));
somme=0;
for kk=1:1:length(indices_R)-1
    rc(1,kk)=indices_R(kk+1)-indices_R(kk);
    somme=somme+rc(kk);
end
rythme_card=(somme/length(indices_R))-100;


% % x11=x(1:1:length(f1));
%
% figure()
% plot(f1,x11);

% figure()
% spectrogram(x,w,d,f,Fs,'yaxis');

% ax = gca;
% ax.YDir = 'reverse';

