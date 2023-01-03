%% Introduction

clear ;
close all;
clc;

%%Tachycardia/Bradycardia
%%signal=load;;;
%R=listedes peak R
c=Cardiacrhythm(R);
fs=signal.Fs;
if 60/(c*fs)<60
    disp('bradycardia')
elseif 60/(c*fs)>100
    disp('tachycardia')
end


