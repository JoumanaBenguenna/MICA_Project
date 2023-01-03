function [P,T] = PTdetection(R,S,Q,ecg)

%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
s=length(R);
P = zeros(1,s); %save index of P wave
T = zeros(1,s); %save index of T wave

x1=zeros(1,7);
x1(1)=1; x1(7)=-1; 
x=filter(x1,[1],ecg);

y2= zeros(1,9);
y2(1)=1; y2(9)=-1;
y=filter(y2,[1 -1],x);


for i=1:s
    limit=floor(0.7*(R(i+1)-R(i))+R(i));
    intervalT= y(S(i):limit);
    intervalP=y(limit:Q(i));
    MT=max(intervalT);
    MP=max(intervalP);
    T(i)=find(intervalT==MT)+S(i);
    P(i)=find(intervalP==MP)+limit;
end





