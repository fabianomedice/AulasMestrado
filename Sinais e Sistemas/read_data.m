function y = read_data(nome)
% Transforma todas as virgulas do LabVIEW em pontos para o MatLAB
comma2point_overwrite(nome); 
% Adquire os dados a partir da linha 24 (linha inicial é 0, por isto o 23)
% pegando o tempo (coluna 0) e o sinal (coluna 1)
y = dlmread(nome,'\t',23,0);
