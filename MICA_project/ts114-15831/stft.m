function [X,f,t] = stft(x,w,d,N_fft,Fs)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% d=50;
%N_fft=2^nextpow2(N);
%w=hamming(N);
L=length(x);
N=100;
M=fix(L/d);
x1= zeros(N,M);


%Fenetrage
for j=1:M
    if j<=M-1
        x1(:,j)=transpose(x(1+d*(j-1):(j-1)*d+N));
    else
        x1(:,M)=[transpose(x(1+d*(M-2):(M-2)*d+d)) ; zeros(N-d,1)];
    end

end

%MULTIPLICATION FENTRE DE HAMMING
Xn=zeros(N,M);

for i=1:N
    wi=transpose(w);
    for j=1:M
        Xn(i,j)=x1(i,j).*wi(:,1);
    end
end

%Transformé de fourrier
X=zeros(N_fft,M);
for k=1:M
    X(:,k)=fft(transpose(Xn(:,k)),N_fft);
end

%Frequence et temps
% f=0:1/(N_fft*Fs):(N_fft-1)/(N_fft*Fs);
% f=0:1/(N_fft*Fs):(N_fft-1)/(N_fft*Fs);
% t = (0:L)/Fs ;
f=Fs*linspace(-0.5, 0.5,N_fft);
t=linspace(0,L/Fs,L);
end





