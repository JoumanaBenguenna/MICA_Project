%% Introduction

clear ;
close all;
clc;

%% Partie 5

% Si ce sont les ecg AF,VF,SSS ou PVC qui veulent être traités, changer le
% 200 de la ligne 109 par 50 ou 30

load('ecg_normal_1.mat');
taille_ecg=length(ecg);


plot((1:taille_ecg)/Fs,ecg);
xlabel('Time (s)');
ylabel('Amplitude');
title('ECG normal 1');
grid on;
legend('ECG');
figure();


% Implémentation filtre passe-bas

x1=zeros(1,13);
x1(1)=1; x1(13)=1; x1(7)=-2;
passe_bas=filter(x1,[1 -2 1],ecg);

retard1=5;

%Implémentation filtre passe-haut

y2= zeros(1,33);
y2(1)=-1; y2(17)=32; y2(18)=-32; y2(33)=1;
y=filter(y2,[1 -1],passe_bas);

retard2=16;

%nous utiliserons y plus tard pour la detection du maximum

% Implémentation du filtre dérivateur
% Après avoir factorisé par z^2, on implémente 2 filtres
    % Le premier (causal)
    
z_der=filter([1 2 0 -2 -1]*Fs/8,1,y);
retard3 = 2;

    % Le deuxième qui décale seulement le signal de 2
decalage1=[0 0];
zdecale = [decalage1 z_der];
retard4=2;


% Module au carré

z_module_carre=abs(zdecale).^2;


% Moving window integration
  %calcul de la periode manuellement : 25
periode=25;
z_mwi=zeros(1,length(z_module_carre)); %initialisation

retard5= 12;

for n=periode:length(z_module_carre)
    t=0;
    for i=0:periode-1
        t=t+z_module_carre(n-i);        
    end
    z_mwi(periode+n)=t/periode;
end 


% Seuillage

seuil=0.9*mean(z_mwi);

window=zeros(1,length(z_mwi)); %initialisation fenetres

for i=1:length(z_mwi)
    if z_mwi(i)> seuil
        window(i)=1;
    end
    
end    



% Detection QRS

% 1. Décalage de y d'un retard total accumulé à cause des filtres.

retardtot= retard1+ retard2 +retard3+ retard4 +retard5;

window=window(retardtot:end);
window=[window ones(1,length(y)-length(window))]; %ajustement longueur pour pouvoir faire le fenetrage


% 2.Fenetrage de y

yfenetree=y.*window;

% 3. Calcul maximum et minimum

indice_yfenetre=find(yfenetree);
indices_R=zeros(1,200);
indices_Q=zeros(1,length(indices_R));
indices_S=zeros(1,length(indices_R));

j=1;
for t=1:length(indices_R)
 
liste_intermediaire=zeros(1,50);
liste_indice_intermediaire=zeros(1,50);
while indice_yfenetre(j+1)-indice_yfenetre(j)==1
    liste_indice_intermediaire(j)=indice_yfenetre(j);
    liste_intermediaire(j)=yfenetree(indice_yfenetre(j)); 
    j=j+1;
end
j=j+1;
indices_R(t)=liste_indice_intermediaire(liste_intermediaire==max(liste_intermediaire));
indices_Q(t)=liste_indice_intermediaire(liste_intermediaire==min(liste_intermediaire(1:find(liste_intermediaire==max(liste_intermediaire)))));
indices_S(t)=liste_indice_intermediaire(liste_intermediaire==min(liste_intermediaire(find(liste_intermediaire==max(liste_intermediaire)):end)));
end





%Affichage 

plot((1:taille_ecg)/Fs,passe_bas);
xlabel('time (s)');
ylabel('amplitude');
title('ECG normal 1 after low pass filter : x(t)');
legend('x(t)');
grid on;
figure();

plot((1:taille_ecg)/Fs,y);
xlabel('Time (s)');
ylabel('Amplitude');
title('x(t) after high pass filter : y(t)');
legend('y(t)');
grid on;
figure();


plot((1:taille_ecg+2)/200,zdecale);
xlabel('time (s)');
ylabel('amplitude');
title('y(t) after differentiation : z(t)');
legend('z(t)');
grid on;
figure();

plot((1:taille_ecg+2)/200,z_module_carre);
xlabel('time (s)');
ylabel('amplitude');
title('z(t) after being squared : z_s_q_u_a_r_e_d(t)');
legend('z_s_q_u_a_r_e_d(t)');
grid on;
figure();

plot((1:taille_ecg+27)/200,z_mwi);
xlabel('time (s)');
ylabel('amplitude');
title('z_s_q_u_a_r_e_d(t) after the Moving-Window Integration : z_M_W_I(t)');
legend('z_M_W_I(t)');
grid on;
figure();


plot((1:taille_ecg)/200,yfenetree);
xlabel('time (s)');
ylabel('amplitude');
title('the signal after fenestration');
legend('y_f(t)');
grid on;
















