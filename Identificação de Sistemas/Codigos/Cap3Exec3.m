clear all;
close all;
clc;
 
%Definindo as vari�veis
omega = 2*pi/8; %Frequencia natural
sigma = 0.24; %Coeficiente de amortecimento

%Definindo a Fun��o de Transferencia
s = tf('s');  
H = exp(-s)*(0.5*omega^2)/((3.8*s+1)*(s^2+2*omega*sigma*s+omega^2))

%Usando a entrada degrau unit�rio
step(H)
grid on;
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',12);
