clear all;
close all;
clc;

%Definindo a Função de Transferencia em malha aberta
s = tf('s');  
HMalhaAberta = exp(-s)/((2*s+1)*(s+1)*(0.5*s+1))
RespostaHMalhaAberta = step(HMalhaAberta);

%Definindo as variáveis
K = 1; %Ganho do Controlador

%Definindo a Função de Transferencia em malha fechada
HMalhaFechada = K*(1-0.5*s)/((2*s+1)*(s+1)*(0.5*s+1)*(1+0.5*s)+K*(1-0.5*s))

%Usando a entrada degrau unitário
step(HMalhaFechada)
grid on;
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',12);

%Definindo a Função de Transferencia em malha aberta de primeira ordem
Haproximado = exp(-6.6826*s)/(3.1267*s+1)
RespostaHaproximado = step(Haproximado);

figure()
plot(RespostaHMalhaAberta,'--k','linewidth',3);
hold on;
plot(RespostaHaproximado,'b','linewidth',2);
xlabel('Time(seconds)');
ylabel('Amplitude');
legend('H(s) Original','H(s) Aproximado');
title('Step Response')
hold off;
grid on;
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',12);


