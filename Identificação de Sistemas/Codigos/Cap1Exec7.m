clear all;
close all;
clc;

%Definindo os vetores
%Tempo até 25 semanas
k=1:1:25; 
%As populações x1,x2,x3,x4, N e as Funções F(N) e S(N) zeradas
x1=zeros(1,length(k)+1);
x2=zeros(1,length(k)+1);
x3=zeros(1,length(k)+1);
x4=zeros(1,length(k)+1);
N=zeros(1,length(k)+1);
F_N=zeros(1,length(k)+1);
S_N=zeros(1,length(k)+1);

%Definindo o tempo do experimento
tempo=0:length(k);

%Valores iniciais
x1(1)=11;
x2(1)=11;
x3(1)=11;
x4(1)=11;

i=1;
while i<=length(k)+1
    %Simulação do tempo 0 a 24 semanas
    if(i<length(k)+1)
        %Calculo das Funções
        N(i)=x1(i)+x2(i)+x3(i)+x4(i);
        F_N(i)=18.53*log(N(i))-1.74*(log(N(i)))^2-44.04;
        S_N(i)=1.35-0.14*log(N(i));

        %Fazendo as Matrizes X_mais_1 = A * X
        A = [0 0 F_N(i) F_N(i);S_N(i) 0 0 0;0 S_N(i) 0 0; 0 0 S_N(i) 0];
        X = [x1(i);x2(i);x3(i);x4(i)];
        Xmais1 = A*X;
    
        %Recebendo os valores da proxima semana
        x1(i+1)= Xmais1(1);
        x2(i+1)= Xmais1(2);
        x3(i+1)= Xmais1(3);
        x4(i+1)= Xmais1(4);
        
    else
        %Simulação do tempo 25 semanas
        %Calculo das Funções
        N(i)=x1(i)+x2(i)+x3(i)+x4(i);
        F_N(i)=18.53*log(N(i))-1.74*(log(N(i)))^2-44.04;
        S_N(i)=1.35-0.14*log(N(i));
        
    end
    i=i+1;
end

figure()
title('Fertilidade e Sobrevivência');
plot(tempo,F_N,'--k','linewidth',3);
hold on;
plot(tempo,S_N,'b','linewidth',2);
xlabel('Semanas');
legend('Fertilidade','Sobrevivência');
hold off;
grid on;
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',12);

figure()
title('População Total e Faixa Etária');
plot(tempo,N,'--r','linewidth',3);
hold on;
plot(tempo,x1,'b','linewidth',3);
hold on;
plot(tempo,x2,'k','linewidth',3);
hold on;
plot(tempo,x3,'g','linewidth',3);
hold on;
plot(tempo,x4,'y','linewidth',3);
xlabel('Semanas');
legend('N','x_1','x_2','x_3','x_4');
hold off;
grid on;
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',14);

