function [modelo] = HIV_celulas_CD4(t,x)
%Funcao para o exercicio 1.9 que representa a dinamica do vírus HIV e células CD4 em função de doses de fármacos
%Parâmetros do sistema
s=10;
r=0.52;
Tmax=1700;
mi1=0.4;
mi2=0.5;
mi3=0.03;
miv=2.4;
k10=0.000024;
k20=0.3;
N0=1400;
omega=1;
alfa1=0.005;
alfa2=0.005;
beta1=0.1;
beta2=65470;
teta=1000000;

%Calculo das funções dos fármacos
m1=600-300*sin(t/10);
m2=600-300*cos(t/10);
k1_m1t=k10*exp(-alfa1*m1);
k2_m2t=k20*exp(-alfa2*m2);

%Variaveis
x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);

%Calculo das Funções
S = (s*teta)/(teta+x4);
lambda = r*(1-((x1+x2+x3)/(Tmax)));
N = beta2*(beta2-N0)*exp(-beta1*t);


modelo =[S+lambda*x1-x1*(mi1+k1_m1t*x4); omega*k1_m1t*x4*x1-x2*(mi2+k2_m2t);(1-omega)*k1_m1t*x4*x1+k2_m2t*x2-mi3*x3; N*mi3*x3-x4*(k1_m1t*x1+miv)];

end