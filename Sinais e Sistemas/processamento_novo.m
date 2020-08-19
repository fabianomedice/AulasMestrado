function y = processamento(nome)
%adquire o sinal
sinal = read_data(nome);

%separa o tempo e os dados do sinal
tamanho_sinal = size (sinal);
linha = 1;
while linha <= tamanho_sinal(1)
    tempo_sinal(linha,1) = sinal(linha,1);
    dados_sinal(linha,1) = sinal(linha,2);
    linha = linha + 1;
end

fa=6000;

% %Plota o sinal puro
% figure
% plot(tempo_sinal,dados_sinal)
% xlabel ('X - Tempo do sinal')
% ylabel ('Y - Tens�o')

%tempo maximo do meu vetor tempo
tempo_max = tempo_sinal(tamanho_sinal(1));
%n�mero de intervalos de 1 seg, retirando o primeiro intervalo
duracao_janela = 1;
intervalos = floor(tempo_max/duracao_janela)-1;
%tempo minimo para acomoda��o (retirando o primeiro intervalo da dura��o da
%janela e o tempo extra que n�o d� um intervalo)
tempo_min = tempo_max - (duracao_janela*intervalos);

%%utiliza FFT nas janelas de tempo 
i=1;
intervalo = 1;
%indice do vetor tempo e linha da matriz de ffts
i_tempo = 1;
%mantem o while enquanto n�o chego no tempo_max
while tempo_sinal(i) < tempo_max 
    %enquando eu n�o passar do tempo minimo, n�o come�o nada
    if tempo_sinal(i) >= tempo_min
        if intervalo <= intervalos
            j = 1;
            %limpa toda a variavel dados_intervalo para n�o trazer lixo da
            %anterior
            clear dados_intervalo;
            clear condicao;
            %pega todos os dados menos o �ltimo
            condicao = tempo_min + duracao_janela*intervalo;
            while tempo_sinal(i) < condicao
                dados_intervalo(j) = dados_sinal(i);
                i = i + 1;
                j = j + 1;
            end
            %pega apenas o �ltimo dado
            if tempo_sinal(i) == condicao
                dados_intervalo(j) = dados_sinal(i);
                %se for o �ltimo tempo (tempo_max), n�o se pode somar i+1 
                %para n�o dar erro, pois n�o existe tempo maior que ele
                if i ~= tamanho_sinal(1)
                    i = i + 1;
                end
            end
            vetor_tempo(i_tempo) = condicao;
            intervalo = intervalo+1;            
        end      
        %faz a fft dos dados_intervalo
        vetor_frequencia_fft = fft(dados_intervalo);
        tamanho_vetor = size(vetor_frequencia_fft);
        %joga o vetor_frequencia na matriz_fft
        k=1;
        %pega todos os dados menos o �ltimo
        %%tamanho/2 pois o sinal � espelhado
        %%Por o tamanho do vetor poder ser impar, tras para o valor de baixo
        %while k < floor(tamanho_vetor(2)/2)
        %500Hz foi a frequencia de corte na aquisi��o
        while k < 500
            %padronizando, a amplitude do valor na frequencia tem que ser
            %dividida pela frequencia de amostragem
            matriz_fft(i_tempo,k) = abs(vetor_frequencia_fft(k))/fa;
            k = k + 1;                              
        end
        %pega apenas o �ltimo dado
        %%tamanho/2 pois o sinal � espelhado
        %%Por o tamanho do vetor poder ser impar, tras para o valor de baixo       
        %if k == floor(tamanho_vetor(2)/2)
        %500Hz foi a frequencia de corte na aquisi��o
        if k == 500
            %padronizando, a amplitude do valor na frequencia tem que ser
            %dividida pela frequencia de amostragem
            matriz_fft(i_tempo,k) = abs(vetor_frequencia_fft(k))/fa;               
        end
        i_tempo = i_tempo + 1;
    else
        i = i + 1;
    end
end

%Cria as frequencias para o eixo de frequencias do grafico
tamanho_matriz_fft = size(matriz_fft);
vetor_frequencia_grafico = 1:tamanho_matriz_fft(2);

% figure
% %Plota o espectograma de frequencia para cada linha de tempo
% mesh (vetor_tempo,vetor_frequencia_grafico,matriz_fft')
% xlabel ('X - Janela de Tempo do sinal')
% ylabel ('Y - Frequencia')
% zlabel ('Z - Valor RMS')
% 
% figure
% %cria o espectrograma para os valores de rms (utiliza log 10 pra melhor
% %visualizar)
% imagesc(vetor_tempo,vetor_frequencia_grafico,matriz_fft')
% %coloca a legenda de cor
% legenda_de_cor = colorbar;
% title (legenda_de_cor,'Amplitude')
% %%coloca as cores em escala cinza
% %colormap(gray)
% %corrige o zero do spectro
% axis xy
% xlabel ('Janela de Tempo de 1 seg')
% ylabel ('Frequencia')

%Chama o filtro Butterworth de 2 ordem passa alta
%Utiliza-se 10Hz de frequencia de corte, devido ao protocolo SENIAM

dados_sinal_butterworth = filtro_butterworth (dados_sinal,10,fa);

% %Plota o sinal filtrado
% figure
% plot(tempo_sinal,dados_sinal,'b',tempo_sinal,dados_sinal_butterworth,'r')
% legend ('Sinal Puro','Sinal Butterworth')
% xlabel ('X - Tempo do sinal')
% ylabel ('Y - Tens�o')

%%utiliza FFT nas janelas de tempo 
i=1;
intervalo = 1;
%indice do vetor tempo e linha da matriz de ffts
i_tempo = 1;
%mantem o while enquanto n�o chego no tempo_max
while tempo_sinal(i) < tempo_max 
    %enquando eu n�o passar do tempo minimo, n�o come�o nada
    if tempo_sinal(i) >= tempo_min
        if intervalo <= intervalos
            j = 1;
            %limpa toda a variavel dados_intervalo para n�o trazer lixo da
            %anterior
            clear dados_intervalo;
            clear condicao;
            %pega todos os dados menos o �ltimo
            condicao = tempo_min + duracao_janela*intervalo;
            while tempo_sinal(i) < condicao
                dados_intervalo(j) = dados_sinal_butterworth(i);
                i = i + 1;
                j = j + 1;
            end
            %pega apenas o �ltimo dado
            if tempo_sinal(i) == condicao
                dados_intervalo(j) = dados_sinal_butterworth(i);
                %se for o �ltimo tempo (tempo_max), n�o se pode somar i+1 
                %para n�o dar erro, pois n�o existe tempo maior que ele
                if i ~= tamanho_sinal(1)
                    i = i + 1;
                end
            end
            vetor_tempo(i_tempo) = condicao;
            intervalo = intervalo+1;            
        end      
        %faz a fft dos dados_intervalo
        vetor_frequencia_fft = fft(dados_intervalo);
        tamanho_vetor = size(vetor_frequencia_fft);
        %joga o vetor_frequencia na matriz_fft
        k=1;
        %pega todos os dados menos o �ltimo
        %%tamanho/2 pois o sinal � espelhado
        %%Por o tamanho do vetor poder ser impar, tras para o valor de baixo
        %while k < floor(tamanho_vetor(2)/2)
        %500Hz foi a frequencia de corte na aquisi��o
        while k < 500
            %padronizando, a amplitude do valor na frequencia tem que ser
            %dividida pela frequencia de amostragem
            matriz_fft_butterworth(i_tempo,k) = abs(vetor_frequencia_fft(k))/fa;
            k = k + 1;                              
        end
        %pega apenas o �ltimo dado
        %%tamanho/2 pois o sinal � espelhado
        %%Por o tamanho do vetor poder ser impar, tras para o valor de baixo       
        %if k == floor(tamanho_vetor(2)/2)
        %500Hz foi a frequencia de corte na aquisi��o
        if k == 500
            %padronizando, a amplitude do valor na frequencia tem que ser
            %dividida pela frequencia de amostragem
            matriz_fft_butterworth(i_tempo,k) = abs(vetor_frequencia_fft(k))/fa;               
        end
        i_tempo = i_tempo + 1;
    else
        i = i + 1;
    end
end

%Cria as frequencias para o eixo de frequencias do grafico
tamanho_matriz_fft = size(matriz_fft_butterworth);
vetor_frequencia_grafico = 1:tamanho_matriz_fft(2);

% figure
% %Plota o espectograma de frequencia para cada linha de tempo
% mesh (vetor_tempo,vetor_frequencia_grafico,matriz_fft_butterworth')
% xlabel ('X - Janela de Tempo do sinal')
% ylabel ('Y - Frequencia')
% zlabel ('Z - Valor RMS')
% 
% figure
% %cria o espectrograma para os valores de rms (utiliza log 10 pra melhor
% %visualizar)
% imagesc(vetor_tempo,vetor_frequencia_grafico,matriz_fft_butterworth')
% %coloca a legenda de cor
% legenda_de_cor = colorbar;
% title (legenda_de_cor,'Amplitude')
% %%coloca as cores em escala cinza
% %colormap(gray)
% %corrige o zero do spectro
% axis xy
% xlabel ('Janela de Tempo de 1 seg')
% ylabel ('Frequencia')


%Chama o filtro notch de 2 ordem para retirar as interferencias da rede
%Analizando o espectro da original e butterworth, as frequencias de corte
%houve interferencia da rede de 60Hz e seus harmonicos
%Qualidade do filtro
q=35;

%Retirando 60Hz
sinal_filtrado_60hz = filtro_notch(dados_sinal_butterworth,60,fa,q); 
%Retirando 120Hz
sinal_filtrado_120hz = filtro_notch(sinal_filtrado_60hz,120,fa,q);
%Retirando 180Hz
sinal_filtrado_180hz = filtro_notch(sinal_filtrado_120hz,180,fa,q);
%Retirando 240Hz
sinal_filtrado_240hz = filtro_notch(sinal_filtrado_180hz,240,fa,q);
%Retirando 300Hz
sinal_filtrado_300hz = filtro_notch(sinal_filtrado_240hz,300,fa,q);
%Retirando 360Hz
sinal_filtrado_360hz = filtro_notch(sinal_filtrado_300hz,360,fa,q);
%Retirando 420Hz
sinal_filtrado_420hz = filtro_notch(sinal_filtrado_360hz,420,fa,q);
%Retirando 480Hz
sinal_filtrado = filtro_notch(sinal_filtrado_420hz,480,fa,q);

%Plota o sinal filtrado
figure
plot(tempo_sinal,dados_sinal,'b',tempo_sinal,dados_sinal_butterworth,'r',tempo_sinal,sinal_filtrado,'k')
legend ('Sinal Puro','Sinal Butterworth','Sinal Butterworth Notch')
xlabel ('X - Tempo do sinal')
ylabel ('Y - Tens�o')

%%utiliza FFT nas janelas de tempo 
i=1;
intervalo = 1;
%indice do vetor tempo e linha da matriz de ffts
i_tempo = 1;
%mantem o while enquanto n�o chego no tempo_max
while tempo_sinal(i) < tempo_max 
    %enquando eu n�o passar do tempo minimo, n�o come�o nada
    if tempo_sinal(i) >= tempo_min
        if intervalo <= intervalos
            j = 1;
            %limpa toda a variavel dados_intervalo para n�o trazer lixo da
            %anterior
            clear dados_intervalo;
            clear condicao;
            %pega todos os dados menos o �ltimo
            condicao = tempo_min + duracao_janela*intervalo;
            while tempo_sinal(i) < condicao
                dados_intervalo(j) = sinal_filtrado(i);
                i = i + 1;
                j = j + 1;
            end
            %pega apenas o �ltimo dado
            if tempo_sinal(i) == condicao
                dados_intervalo(j) = sinal_filtrado(i);
                %se for o �ltimo tempo (tempo_max), n�o se pode somar i+1 
                %para n�o dar erro, pois n�o existe tempo maior que ele
                if i ~= tamanho_sinal(1)
                    i = i + 1;
                end
            end
            vetor_tempo(i_tempo) = condicao;
            intervalo = intervalo+1;            
        end      
        %faz a fft dos dados_intervalo
        vetor_frequencia_fft = fft(dados_intervalo);
        tamanho_vetor = size(vetor_frequencia_fft);
        %joga o vetor_frequencia na matriz_fft
        k=1;
        %pega todos os dados menos o �ltimo
        %%tamanho/2 pois o sinal � espelhado
        %%Por o tamanho do vetor poder ser impar, tras para o valor de baixo
        %while k < floor(tamanho_vetor(2)/2)
        %500Hz foi a frequencia de corte na aquisi��o
        while k < 500
            %padronizando, a amplitude do valor na frequencia tem que ser
            %dividida pela frequencia de amostragem
            matriz_fft_butterworth_notch(i_tempo,k) = abs(vetor_frequencia_fft(k))/fa;
            k = k + 1;                              
        end
        %pega apenas o �ltimo dado
        %%tamanho/2 pois o sinal � espelhado
        %%Por o tamanho do vetor poder ser impar, tras para o valor de baixo       
        %if k == floor(tamanho_vetor(2)/2)
        %500Hz foi a frequencia de corte na aquisi��o
        if k == 500
            %padronizando, a amplitude do valor na frequencia tem que ser
            %dividida pela frequencia de amostragem
            matriz_fft_butterworth_notch(i_tempo,k) = abs(vetor_frequencia_fft(k))/fa;               
        end
        i_tempo = i_tempo + 1;
    else
        i = i + 1;
    end
end

%Cria as frequencias para o eixo de frequencias do grafico
tamanho_matriz_fft = size(matriz_fft_butterworth_notch);
vetor_frequencia_grafico = 1:tamanho_matriz_fft(2);

figure
%Plota o espectograma de frequencia para cada linha de tempo
mesh (vetor_tempo,vetor_frequencia_grafico,matriz_fft_butterworth_notch')
xlabel ('X - Janela de Tempo do sinal')
ylabel ('Y - Frequencia')
zlabel ('Z - Valor RMS')

figure
%cria o espectrograma para os valores de rms (utiliza log 10 pra melhor
%visualizar)
imagesc(vetor_tempo,vetor_frequencia_grafico,matriz_fft_butterworth_notch')
%coloca a legenda de cor
legenda_de_cor = colorbar;
title (legenda_de_cor,'Amplitude')
%coloca as cores em escala cinza
colormap(gray)
%corrige o zero do spectro
axis xy
xlabel ('Janela de Tempo de 1 seg')
ylabel ('Frequencia')

