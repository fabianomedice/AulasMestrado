function [modelo] = cadeia_alimentar(t,x)
%Funcao para o exercicio 1.8 que representa a dinamica de uma cadeia alimentar
%Constantes fornecidas:
a = 0.311;
b = 0.518;
c = 1.036;
d = 0.311;
e = 0.161;
f = 4.599;
g = 2.469;
h = 0.322;

%Variaveis
X = x(1);
Y = x(2);
Z = x(3);

modelo =[ X*(1-X)-X*Y/(X+a); -b*Y+(c*X*Y)/(X+d)-(Y*Z)/(Y+e); f*Z^2-(g*Z^2)/(Y+h)];

end

