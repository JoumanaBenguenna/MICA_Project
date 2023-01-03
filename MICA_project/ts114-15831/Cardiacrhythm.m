function [delta] = Cardiacrhythm(R)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N=length(R);
deltan=0;
for i=1:N-1
    deltan=deltan+R(i+1)-R(i);
end
delta=1/N*deltan;
end