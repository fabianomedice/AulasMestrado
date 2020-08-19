function [Fi,S] = Decomposicao_VR(Rk1,Rk0)%L

%Avr,Dr
R=Rk1-Rk0;
%R=L;
[l,c]=size(R); % Matriz quadrada e singular
posto=rank(R); %Me da o número de linhas independentes

if posto ==0 %Nenhuma independente e não nula
    
    Fi=zeros(l,1);
    S=1;
    
elseif posto<l %Como rank dá <0?
    
    quantidade= l-posto;
    
    [AV,D]=eig(R); %Autovetores de R na matriz Av e Autovalores de R na matriz diagonal D
    polos=diag(D); %Pegou apenas os autovalores da diagonal. 
    [y,index] = sort(abs(polos)); %Deixa os polos positivos e coloca eles em ordem crescente
    index_restante = index((quantidade+1):end);
    Avr=AV(:,index_restante);
    Dr=D(index_restante,index_restante);
    
    w=sqrt(abs(Dr));
    
    Fi=Avr*w;
    S=(w\Dr)/w;
else   

    [Avr,Dr]=eig(R);%Autovetores de R na matriz Avr e Autovalores de R na matriz diagonal Dr
%     
%     Fi = sqrt(abs(Dr));
%     S = Avr\Avr;
    
    w=sqrt(abs(Dr));%Colocando positivo e tirando a raiz quadrada (Fazendo a Norma)
    
    Fi=Avr*w; %Achando o valor de Fi
    S=(w\Dr)/w; %\calcula a divisão da inversa de w e / calcula a divisão pela inversa de w
        
end
end