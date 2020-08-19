clear all
clc

%Fazendo a função de transferencia do sistema
z = tf('z');  
H = (0.1701*z+0.1208)/(z^2-0.7859*z+0.3679)

ru = (0.7*z^6+1.43*z^5+2.18*z^4+2.94*z^3+2.18*z^2+1.43*z+0.7)/z^3 

ruy = H*ru

% syms Z
% RU = iztrans((0.7*Z^6+1.43*Z^5+2.18*Z^4+2.94*Z^3+2.18*Z^2+1.43*Z+0.7)/Z^3 )
impulse(H)