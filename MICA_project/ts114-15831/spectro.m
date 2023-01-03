function [Sx, f, t] = spectro(x,w,d,N_fft,Fs)

    [X,f,t]=stft(x,w,d,N_fft,Fs);
    N=100;
    Sx=(1/N)*(abs(X)).^2;
    
    
    


   