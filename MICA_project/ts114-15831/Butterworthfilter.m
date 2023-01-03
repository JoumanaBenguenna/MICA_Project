
%Applying filter to signal


x=load('ecg_noisePL.mat');
ecg=x.ecg;
Fs=x.Fs;
n=length(ecg);
f = (-n/2:n/2-1)*(Fs/n);
%time evolution
plot(-ecg(1:400));
xlabel('Time(s)')
ylabel('ECG')
title('Time evolution ECG')
figure();

%power spectrum

DSP=fftshift(abs(fft(xcorr(-ecg,'biase'),n)));
plot(f,DSP);
xlabel('Frequency (Hz)')
ylabel('ECG')
title('Power Spectrum ECG')
figure();

%butterworth filter

d=butterworth;
fvtool(d);

%power spectrum of filtered ecg

fDSP=fftshift(abs(fft(xcorr(filter(d,-ecg),'biase'),n)));
plot(f,fDSP);
xlabel('Frequency (Hz)')
ylabel('ECG')
title('Power Spectrum of filtered ECG')
figure();
