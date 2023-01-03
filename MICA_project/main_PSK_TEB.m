%% noms des bin�mes
clear; % Efface les variables de l?environnement de
travail
close all; % Ferme les figures ouvertes
clc; % Efface la console

 %% Initialisation des param�tres
fe = 1e4; % Fr�quence d?�chantillonnage 8 
M = 4; % Nombre de symboles dans la modulation

n_b = log2(M); % Nombre de bits par symboles
 % ... autres param�tres

Eg = % Energie du filtre de mise en forme


sigA2 = % Variance th�orique des symboles

eb_n0_dB = 0:0.5:10; % Liste des Eb/N0 en dB
eb_n0 = 10.^(eb_n0_dB/10); % Liste des Eb/N0

sigma2 = sigA2 * Eg ./ (n_b * eb_n0); % Variance du bruit complexe en bande de base

TEB = zeros(size(eb_n0)); % Tableau des TEB (r�sultats) 
Pb = qfunc(sqrt(2*eb_n0)); % Tableau des probabilit�s d?erreurs th�oriques

for i = 1:length(eb_n0)
    error_cnt = 0;
    bit_cnt = 0;
    while error_cnt < 100 
     
        
        nl = sqrt(sigma2(i)/2) * (randn(size(sl)) + 1j*randn(size(sl))); % G�n�ration du bruit blanc gaussien complexe 
      
        error_cnt = error_cnt + ... % incr�menter le compteur d?erreurs
        bit_cnt = bit_cnt + ... % incr�menter le compteur de bits envoy�s
    end
    TEB(i) = error_cnt/bit_cnt;
end


