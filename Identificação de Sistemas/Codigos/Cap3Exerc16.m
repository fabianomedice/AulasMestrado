clear all
clc

%Carregando os dados MF644.DAT
Data = load ('MF644.DAT');

%Colocando y(0)=0
NewData = Data - Data(1);

plot (NewData)

%Definindo a Função de Transferencia em Malha Fechada
s = tf('s');  
H = (7.701*(1-4.6488*s))/((14.6818*s+1)*(1+4.6488*s)+7.701*(1-4.6488*s))
 
%Usando a entrada degrau unitário
figure()
%criando as opções da entrada degrau
opt = stepDataOptions('InputOffset',0,'StepAmplitude',28);
%usado a entrada degrau
step(H,opt)
grid on;
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',12);

%Definindo a Função de Transferencia em Malha Aberta
Kc=2;
HAberto = (3.8505*exp(-9.2976*s))/(14.6818*s+1)
HFechado = feedback(HAberto,Kc)

%Usando a entrada degrau unitário
figure()
%criando as opções da entrada degrau
opt = stepDataOptions('InputOffset',0,'StepAmplitude',28);
%usado a entrada degrau
step(HFechado,opt)
grid on;
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',12);
