function [indices_R] = QRS(x,Fs)
% A=length(x);


% xlabel('time (s)');
% ylabel('amplitude');
% title('ECG');



%passe bas
x1=zeros(1,13);
x1(1)=1; x1(13)=1; x1(7)=-2;
passe_bas=filter(x1,[1 -2 1],-x);

retard1=5;

%passe haut

y2= zeros(1,33);
y2(1)=-1; y2(17)=32; y2(18)=-32; y2(33)=1;
y=filter(y2,[1 -1],passe_bas);

retard2=16;

%nous utiliserons y plus tard pour la detection du maximum

%derivative
z_der=filter([1 2 0 -2 -1]*Fs/8,1,y);
retard3 = 2;

decalage1=[0 0];
zdecale = [decalage1 z_der];
retard4=2;


% module au carré
z_module_carre=abs(zdecale).^2;


% Moving window integration
  %calcul de la periode manuellement : 25
p=25;
z_mwi=zeros(1,length(z_module_carre));

retard5= 12;
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

seuil=0.3*mean(z_mwi);

window=zeros(1,length(z_mwi)); %initialisation fenetres

for i=1:length(z_mwi)
    if z_mwi(i)> seuil
        window(i)=1;
    end
    
end    



% Detection R

% 1.decalage retard sur y

retardtot= retard1+ retard2 +retard3+ retard4 +retard5;

window=window(retardtot:end);
window=[window ones(1,length(y)-length(window))]; %ajustement longueur pour pouvoir faire le fenetrage


% 2.maximum


yfenetree=y.*window;

taille=0;
it=1;
while window(it)==0
    it=it+1;
end
it2=it;
while ne(window(it2),0)
    taille=taille+1;
    it2=it2+1;
end




indice_yfenetre=find(yfenetree);
indices_R=zeros(1,210);

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
end






% Q et S detection

%indices_Q=zeros(1,length(indices_R));
%indices_S=zeros(1,length(indices_R));

%for t=1:length(indices_R)
 

%end

% Affichage 
% 
% plot((1:A)/200,passe_bas);
% xlabel('time (s)');
% ylabel('amplitude');
% title('ECG normal 1 after pass-low filter : x(t)');
% legend('x(t)');
% figure();
% plot((1:A)/200,y);
% xlabel('time (s)');
% ylabel('amplitude');
% title('x(t) after pass-high filter : y(t)');
% legend('y(t)');
% figure();
% 
% plot(z_der);
% xlabel('time (s)');
% ylabel('amplitude');
% title('x(t) after pass-high filter : y(t)');
% legend('y(t)');
% figure();
% 
% plot((1:A+2)/200,zdecale);
% xlabel('time (s)');
% ylabel('amplitude');
% title('y(t) after differentiation : z(t)');
% legend('z(t)');
% figure();
% 
% plot((1:A+2)/200,z_module_carre);
% xlabel('time (s)');
% ylabel('amplitude');
% title('z(t) after being squared : z_s_q_u_a_r_e_d(t)');
% legend('z_s_q_u_a_r_e_d(t)');
% figure();
% 
% plot((1:A+27)/200,z_mwi);
% xlabel('time (s)');
% ylabel('amplitude');
% title('z_s_q_u_a_r_e_d(t) after the Moving-Window Integration : z_M_W_I(t)');
% legend('z_M_W_I(t)');
% figure();
% 
 plot(yfenetree);