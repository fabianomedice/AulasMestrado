clear all;
close all;
clc;

%Definindo os vetores
%Tempo 
k=1:1:100; 
%Vetores zeradas
y1=zeros(1,length(k));
y2=zeros(1,length(k));

%Valores iniciais
y1(1)=0;
y1(2)=0;
y2(1)=0;
y2(2)=0;

%Matrizes de constantes
A = [0.4 1.2; 0.3 0.7];
B = [0.35 -0.3; -0.4 -0.5];
C = [1 0; 0 1];

%Matriz do sinal aleatório
u1 = randn(1,length(k));
u2 = randn(1,length(k));

i=3;
while i<=length(k)  
    %Fazendo as Matrizes Y = A * Y_menos_1+ B * Y_menos_2 + C * U
    Y_menos_2 = [y1(i-2);y2(i-2)];
    Y_menos_1 = [y1(i-1);y2(i-1)];  
    U = [u1(i-1);u2(i-1)];
    Y = A*Y_menos_1+B*Y_menos_2+C*U;
    
    %Recebendo os valores da simulação
    y1(i)= Y(1);
    y2(i)= Y(2);
    
    i=i+1;
end

figure()
plot(k,y1,'--k','linewidth',3);
hold on;
plot(k,y2,'b','linewidth',2);
xlabel('Tempo');
legend('Y1(k)','Y2(k)');
hold off;
grid on;
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',12);

figure()
plot(k,u1,'--k','linewidth',3);
hold on;
plot(k,u2,'b','linewidth',2);
xlabel('Tempo');
legend('U1(k)','U2(k)');
hold off;
grid on;
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',12);