%% Introduction

clear ;
close all;
clc;

%% Partie 4

% 
% function [X, f, t] = stft(x,w,d,N_fft,Fs)
%     
%     M=fix(size(x)/d);
%     
% 
% 
% end

load('ecg_normal_1.mat');
A=length(ecg);

plot((1:A)/10000,ecg);
plot((1:A),ecg);
xlabel('temps en minute');
ylabel('amplitude');

figure();

%passe bas
x1=zeros(1,13);
x1(1)=1; x1(13)=1; x1(7)=-2;
x=filter(x1,[1 -2 1],-ecg);

retard1=5;

%passe haut

y2= zeros(1,33);
y2(1)=-1; y2(17)=32; y2(18)=-32; y2(33)=1;
y=filter(y2,[1 -1],x);

retard2=16;

%nous utiliserons y plus tard pour la detection du maximum

%derivative
z_der=filter([1 2 0 -2 -1]*Fs/8,1,y);
retard3 = 2;

zdecale = z_der(2:length(z_der));

% module au carré
z_module_carre=abs(zdecale).^2;


% Moving window integration
  %calcul de la periode manuellement : 30
p=25;
z_mwi=zeros(1,length(z_module_carre));

retard4= 12;
for n=p:length(z_module_carre)
    t=0;
    for i=0:p-1
        t=t+z_module_carre(n-i);        
    end
    z_mwi(p+n)=t/p;
end 

z1=zeros(1,p+1);
z1(1)=1; z1(p+1)=-1;

% Seuillage

seuil=mean(z_mwi);

fenetres=zeros(1,length(z_mwi));

for i=1:length(z_mwi)
    if z_mwi(i)> seuil
        fenetres(i)=z_mwi(i);
    end
    
end    

% Detection R

% decalage retard sur y

retardtot= retard1+retard2+retard3+ retard4;
decalage=zeros(1,retardtot);
ydecaley=[decalage y];

% maximum

% Affichage 

plot(x);
figure();
plot(y);
figure();
plot(z_der);
figure();
plot(zdecale);
figure();
plot(z_module_carre);
figure();
plot(z_mwi);





















% fonction spectogramme

function [Sx, f, t] = spectro(x,w,d,N_fft,Fs)
    stft(x,w,d,N_fft,Fs)= [X,f,t];
    Sx=(1/N)*(abs(X))^2;
    f;
    t;
    


% This function computes the spectrogram for m = [0, d, 2d, 3d...]
   % This function outputs are:
   % -> Sx, which is  a matrix of n_fft lines and
   %                             M (number of elements of m) columns
   %    Sx(i,j) is the value of the spectrogram for time t(i) and frequency f(j)
   % -> f, is a column vector of the frequencies (in Hz)
   % -> t, is a row vector containing the times of the beginning of the windows
end


