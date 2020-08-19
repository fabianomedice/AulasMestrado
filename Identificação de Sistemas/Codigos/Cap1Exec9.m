clear all;
close all;
clc;

%Condições iniciais
%Tempo 224, com intervalo de integração T=0.1
tspan = 0:0.1:244;

%Condições iniciais das variaveis
x0 = [357 10 100 133352];

[tempo_continuo,modelo_continuo]=ode45(@HIV_celulas_CD4,tspan,x0);

figure(1)
plot(tempo_continuo,modelo_continuo(:,1),tempo_continuo,modelo_continuo(:,2),tempo_continuo,modelo_continuo(:,3),tempo_continuo,modelo_continuo(:,4));
grid on;
xlabel('Tempo');
legend('T CD4+ não infectadas','T CD4+ infectadas latentes','T CD4+ infectadas ativas','vírus HIV livres');
title('Dinamica do vírus HIV e células CD4 em função de doses de fármacos');
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',14);
