clear all
clc

%Fazendo a função de transferencia do sistema
z = tf('z');  
H = (0.1701*z+0.1208)/(z^2-0.7859*z+0.3679)

%Faz o diagrama de bode
margin(H)