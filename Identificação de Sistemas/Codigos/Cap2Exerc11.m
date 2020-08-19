clear all;
close all;
clc;

%Matrizes de sistema
A = [0 0 1 0;0 0 0 1;(-14384/355) (14384/355) (-1860/355) (1860/355); (14384/46) ((14384+300000)/46) (1860/46) (-1860/46)];
B = [0; 0; 0; 300000/46];
C = [0 0 0 0];
D = 0;

Sistema = ss(A,B,C,D);

%Condições iniciais
x0 = [0 0 0 0];

%Tempo
t=0:1:200;

%Entradas
%Entrada de pista irregular
U1=sin(t);
%Entrada de quebra mola
U2=zeros(1,length(t)); %zera o vetor
i=0; %coloca sen de 0 a pi nas primeiras 7 variaveis do sinal
while i<7
    U2(i+1)=sin(pi*i/6);
    i=i+1;
end

%Resposta
[Y1,t,X1] = lsim(Sistema,U1,t,x0);
[Y2,t,X2] = lsim(Sistema,U2,t,x0);

figure(1)
plot(t,X1(:,1),t,X1(:,2),t,X1(:,3),t,X1(:,4));
grid on;
xlabel('Tempo');
legend('Posição da Carroceria','Posição da Roda','Velocidade da Carroceria','Velocidade da Roda');
title('Dinamica do carro em uma pista irregular');
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',14);

figure(2)
plot(t,X2(:,1),t,t,X2(:,2), X2(:,3),t,X2(:,4));
grid on;
xlabel('Tempo');
legend('Posição da Carroceria','Posição da Roda','Velocidade da Carroceria','Velocidade da Roda');
title('Dinamica do carro em um quebra-molas');
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',14);