clear all;
close all;
clc;

%Modelo Continuo
%Condições iniciais
y0 = [1 1 1];
tspan = [0 500];
[tempo_continuo,modelo_continuo]=ode45(@cadeia_alimentar,tspan,y0);
figure(1)
plot(tempo_continuo,modelo_continuo(:,1),tempo_continuo,modelo_continuo(:,2),tempo_continuo,modelo_continuo(:,3));
grid on;
xlabel('Tempo');
legend('Presa','Predador Especialista','Predador Generalista');
title('Dinamica de uma cadeia alimentar');
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',14);

%Modelo Discreto
%Condições iniciais
tempo_discreto = 0:500;
x=zeros(1,length(tempo_discreto));
x(1) = 0.7000; %x(k-8)
x(2) = 0.7591; %x(k-7)
x(3) = 0.8151; %x(k-6)
x(4) = 0.8621; %x(k-5)
x(5) = 0.8962; %x(k-4)
x(6) = 0.9203; %x(k-3)
x(7) = 0.9353; %x(k-2)
x(8) = 0.9432; %x(k-1)

for k = 9:length(tempo_discreto)
    x(k) = 3.38040*x(k-1)- 4.30812*x(k-2)+2.56162*x(k-3)-1.06161*x(k-4)-1.21955*x(k-5)^2 ...
        +2.56978*x(k-1)*x(k-5)*x(k-6)-3.26196*x(k-3)*x(k-4)*x(k-6)+0.48632*x(k-5)...
        +2.53047*x(k-4)^2*x(k-5)+0.80920*x(k-4)*x(k-7)-4.55223*10^-3*x(k-1)^2*x(k-8)+1.47483*x(k-3)*x(k-6)...
        -0.23716*x(k-5)^2*x(k-6)-0.74444*x(k-1)*x(k-7)-0.45312*x(k-6)^2+0.50283*x(k-2)^2*x(k-3)...
        -2.02429*x(k-1)*x(k-4)*x(k-5);
end
figure(2)
plot(tempo_discreto,x)
grid on;
xlabel('Tempo');
ylabel('Densidade da presa')
title('Dinamica de uma cadeia alimentar: Densidade da Presa');
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',14);

%Comparacao dos resultados
figure(3)
plot(tempo_continuo,modelo_continuo(:,1),tempo_discreto,x)
grid on;
xlabel('Tempo');
legend('Modelo Continuo', 'Modelo Discreto');
title('Densidade da presa');
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',14);