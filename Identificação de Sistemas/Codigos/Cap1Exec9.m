clear all;
close all;
clc;

%Condi��es iniciais
%Tempo 224, com intervalo de integra��o T=0.1
tspan = 0:0.1:244;

%Condi��es iniciais das variaveis
x0 = [357 10 100 133352];

[tempo_continuo,modelo_continuo]=ode45(@HIV_celulas_CD4,tspan,x0);

figure(1)
plot(tempo_continuo,modelo_continuo(:,1),tempo_continuo,modelo_continuo(:,2),tempo_continuo,modelo_continuo(:,3),tempo_continuo,modelo_continuo(:,4));
grid on;
xlabel('Tempo');
legend('T CD4+ n�o infectadas','T CD4+ infectadas latentes','T CD4+ infectadas ativas','v�rus HIV livres');
title('Dinamica do v�rus HIV e c�lulas CD4 em fun��o de doses de f�rmacos');
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',14);
