clear all;
close all;
clc;
 
%Definindo as variáveis
omega = 2*pi/8; %Frequencia natural
sigma = 0.24; %Coeficiente de amortecimento

%Definindo a Função de Transferencia
s = tf('s');  
H = exp(-s)*(0.5*omega^2)/((3.8*s+1)*(s^2+2*omega*sigma*s+omega^2))

%Usando a entrada degrau unitário
step(H)
grid on;
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',12);
