clear all
clc

%Definindo as funções de transferencias
s = tf('s');

H = (14*s^3+248*s^2+900*s+1200)/(s^4+18*s^3+102*s^2+180*s+120);
Hp = (11.9827*s+12.5318)/(s^2+2.1382*s+1.2532);
Hx = (16.4360*s+88.7840)/(s^2+9.4739*s+8.8784);

%Plotando o plano s das funções
figure
pzmap(H)
figure
pzmap(Hp)
figure
pzmap(Hx)

%Colocando o controlador
C = (2/s);

H_MalhaFechada = (H*C)/(1+H*C)
Hp_MalhaFechada = (Hp*C)/(1+Hp*C)
Hx_MalhaFechada = (Hx*C)/(1+Hx*C)

%Plotando o plano s das funções
figure
pzmap(H_MalhaFechada)
figure
pzmap(Hp_MalhaFechada)
figure
pzmap(Hx_MalhaFechada)