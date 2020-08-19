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

%O labview me da o samples to read e não rate(hz)
fa=6000;
%%%%%%%%%%%%%%%me da a retirada da frequencia de amostragem
%%%%%%%%%%%%%%%busco as 15 primeiras linhas do cabeçario
%%%%%%%%%%%%%%header = importdata(nome,'\n',15);
%%%%%%%%%%%%%%%transformo em char
%%%%%%%%%%%%%%header = char (header);
%%%%%%%%%%%%%%%na linha 15 está a frequencia de amostragem
%%%%%%%%%%%%%%%retirando as 8 primeiras letras do "Samples ", terá o valor de amostragem
%%%%%%%%%%%%%%tamanho = 9;

%%%%%%%%%%%%%%tamanho_header = size (header);
%%%%%%%%%%%%%%while tamanho < tamanho_header(2)
%%%%%%%%%%%%%%    while header(15,tamanho)~= ' '
%%%%%%%%%%%%%%        x(tamanho-8)= header(15,tamanho);
%%%%%%%%%%%%%%        tamanho = tamanho+1;
%%%%%%%%%%%%%%    end
%%%%%%%%%%%%%%    tamanho = tamanho+1;
%%%%%%%%%%%%%%end
%%%%%%%%%%%%%%%frequencia de amostragem
%%%%%%%%%%%%%%fa = str2num (x);

%tempo maximo do meu vetor tempo
tempo_max = tempo_sinal(tamanho_sinal(1));
%número de intervalos de 1 seg, retirando o primeiro intervalo
duracao_janela = 1;
intervalos = floor(tempo_max/duracao_janela)-1;
%tempo minimo para acomodação (retirando o primeiro intervalo da duração da
%janela e o tempo extra que não dá um intervalo)
tempo_min = tempo_max - (duracao_janela*intervalos);
% % 
% % %%varia até a frequencia central fazendo um banco de filtros
% % %a primeira frequencia central
% % fc = 10;
% % %indice do vetor frequencia e coluna da matriz rms
% % i_freq = 1;
% % while fc <= 490
% %     %faz o filtro na banda escolhida
% %     dados_filtrados = filtro (dados_sinal, fc, fa);
% %     %me da o valor vrms nesta banda
% %     %%%%%%%%%%%%rms = vrms (dados_filtrados);
% %     %%%%%%%%%%%%msg = sprintf('%f \t\t %f\n',rms,fc);
% %     %%%%%%%%%%%%disp(msg);
% %     %adiciona de 10 em 10 a frequencia central
% %     i=1;
% %     intervalo = 1;
% %     %indice do vetor tempo e linha da matriz rms
% %     i_tempo = 1;
% %     %mantem o while enquanto não chego no tempo_max
% %     while tempo_sinal(i) < tempo_max        
% %         %enquando eu não passar do tempo minimo, não começo nada
% %         if tempo_sinal(i) >= tempo_min
% %             if intervalo <= intervalos
% %                 j = 1;
% %                 %limpa toda a variavel dados_intervalo para não trazer lixo da
% %                 %anterior
% %                 clear dados_intervalo;
% %                 clear condicao;
% %                 %pega todos os dados menos o último
% %                 condicao = tempo_min + duracao_janela*intervalo;
% %                 while tempo_sinal(i) < condicao
% %                     dados_intervalo(j) = dados_filtrados(i);
% %                     i = i + 1;
% %                     j = j + 1;
% %                 end
% %                 %pega apenas o último dado
% %                 if tempo_sinal(i) == condicao
% %                     dados_intervalo(j) = dados_filtrados(i);
% %                     %se for o último tempo (tempo_max), não se pode somar i+1 
% %                     %para não dar erro, pois não existe tempo maior que ele
% %                     if i ~= tamanho_sinal(1)
% %                         i = i + 1;
% %                     end
% %                 end
% %                 vetor_tempo(i_tempo) = condicao;
% %                 intervalo = intervalo+1;            
% %             end
% %             rms = vrms (dados_intervalo);
% %             matriz_rms(i_tempo,i_freq) = rms;
% %             i_tempo = i_tempo + 1;
% %             %msg = sprintf('%f \t\t %f\n',rms,fc);
% %             %disp(msg);
% %         else
% %             i = i + 1;
% %         end
% %     end
% %     %salva a frequencia no vetor_frequencia
% %     vetor_frequencia(i_freq) = fc;
% %     fc = fc + 10;
% %     i_freq = i_freq + 1;
% % end
% % 
% % %Sinal cru
% % %figure
% % %plot(dados_sinal)
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%interessante, mas n estamos conseguindo visualizar
% % %cria o espectrograma para os valores de rms (utiliza log 10 pra melhor
% % %visualizar)
% % %imagesc(vetor_tempo,vetor_frequencia,log10(matriz_rms'))
% % %coloca a legenda de cor
% % %colorbar
% % %coloca as cores em escala cinza
% % %colormap(gray)
% % %corrige o zero do spectro
% % %axis xy
% % %xlabel ('Janela de Tempo')
% % %ylabel ('Frequencia Central')
% % %Padroniza a escala do colorbar
% % %%%%%%%%%%%escala_min = ;
% % %%%%%%%%%%%escala_max = ;
% % %%%%%%%%%%%escala = [escala_min escala_max];
% % %%%%%%%%%%%caxis (escala);
% % 
% % % figure
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%grafico mais errado, pois o sinal muda com o tempo
% % % %Plota o log de 10 da média dos valores rms dos sinais
% % % plot (vetor_frequencia,log10(mean(matriz_rms))')
% % % xlabel ('Frequencia Central')
% % % ylabel ('Log de 10 da Média do Valor RMS')
% % % 
% % % figure
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%mais correta em minha opinião, pois conseguimos ver a mudança ao longo do tempo
% % % %Plota o valor rms em cada faixa de frequencia para cada linha de tempo
% % % plot (vetor_frequencia,matriz_rms')
% % % xlabel ('Frequencia Central')
% % % ylabel ('Valor RMS')
% % % h = legend (num2str(vetor_tempo'));
% % % v = get(h,'title');
% % % set(v,'string','Janela de Tempo');
% % 
% % figure
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%mais correta em minha opinião, pois conseguimos ver a mudança ao longo do tempo
% % %Plota o valor rms em cada faixa de frequencia para cada linha de tempo
% % mesh (vetor_tempo,vetor_frequencia,matriz_rms')
% % xlabel ('X - Janela de Tempo do sinal')
% % ylabel ('Y - Frequencia Central')
% % zlabel ('Z - Valor RMS')
% % %h = legend (num2str(vetor_tempo'));
% % %v = get(h,'title');
% % %set(v,'string','Janela de Tempo');
% % 
% % figure
% % %Plota a media da amplitude do sinal
% % plot (mean (matriz_rms,2))
% % %Regressão Linear
% % %Segura para plotar outro gráfico
% % hold
% % %Limpando as váriaveis
% % clear x
% % clear y
% % clear a
% % y = mean(matriz_rms,2);
% % x = [1:size(y,1)];
% % %Com N = 1 é linear
% % a = polyfit(x',y,1);
% % LinearFit = a(1)*x + a(2);
% % plot(x,LinearFit)
% % xlabel ('X - Janela de Tempo do sinal')
% % ylabel ('Y - Média da Amplitude')
% % Equacao_Banco_de_Filtros = (['Y = ' num2str(a(1)) ' * X + ' num2str(a(2))])
% % Range_do_plot = axis;
% % text (Range_do_plot(2)/2,Range_do_plot(4)*.98,Equacao_Banco_de_Filtros)

%%utiliza FFT nas janelas de tempo 
i=1;
intervalo = 1;
%indice do vetor tempo e linha da matriz de ffts
i_tempo = 1;
%mantem o while enquanto não chego no tempo_max
while tempo_sinal(i) < tempo_max 
    %enquando eu não passar do tempo minimo, não começo nada
    if tempo_sinal(i) >= tempo_min
        if intervalo <= intervalos
            j = 1;
            %limpa toda a variavel dados_intervalo para não trazer lixo da
            %anterior
            clear dados_intervalo;
            clear condicao;
            %pega todos os dados menos o último
            condicao = tempo_min + duracao_janela*intervalo;
            while tempo_sinal(i) < condicao
                dados_intervalo(j) = dados_sinal(i);
                i = i + 1;
                j = j + 1;
            end
            %pega apenas o último dado
            if tempo_sinal(i) == condicao
                dados_intervalo(j) = dados_sinal(i);
                %se for o último tempo (tempo_max), não se pode somar i+1 
                %para não dar erro, pois não existe tempo maior que ele
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
        %Pega a partir de 2Hz para retirada de artefatos
        %k=2;
        %Pega a partir de 10Hz conforme padrão SENIAM
        k=10;
        %pega todos os dados menos o último
        %tamanho/2 pois o sinal é espelhado
        %while k < tamanho_vetor(2)/2
        %while k < 500
        while k < 400
            %padronizando, a amplitude do valor na frequencia tem que ser
            %dividida pela frequencia de amostragem
            matriz_fft(i_tempo,k) = abs(vetor_frequencia_fft(k))/fa;
            k = k + 1;                              
        end
        %pega apenas o último dado
        %tamanho/2 pois o sinal é espelhado
        %if k == tamanho_vetor(2)/2
        %Frequencia do Passa baixa foi 500Hz
        %if k == 500
        if k == 400
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

figure
%Plota o espectograma de frequencia para cada linha de tempo
mesh (vetor_tempo,vetor_frequencia_grafico,matriz_fft')
xlabel ('X - Janela de Tempo do sinal')
ylabel ('Y - Frequencia')
zlabel ('Z - Valor RMS')

figure
%Plota a media da amplitude do sinal
plot (mean (matriz_fft,2))
%Regressão Linear
%Segura para plotar outro gráfico
hold
%Limpando as váriaveis
clear x
clear y
clear a
%Cria o vetor médias de amplitude de cada tempo do sinal (de cada linha da matriz_fft)
y = mean(matriz_fft,2);
%Cria o vetor de intervalos de tempo (numero de linhas)
x = [1:size(y,1)];

%%%Com N = 1 é linear
%a = polyfit(x',y,1);
%LinearFit = a(1)*x + a(2);
%plot(x,LinearFit)

%%%Com N = 2 é 2º Grau
%a = polyfit(x',y,2);
%LinearFit = a(1)*x.^2 + a(2)*x + a(3);
%plot(x,LinearFit)

%%%Com N = 3 é 3º Grau
% a = polyfit(x',y,3);
% LinearFit = a(1)*x.^3 + a(2)*x.^2 + a(3)*x + a(4);
% plot(x,LinearFit)

% %%%Com N = 4 é 4º Grau
a = polyfit(x',y,4);
LinearFit = a(1)*x.^4 + a(2)*x.^3 + a(3)*x.^2 + a(4)*x + a(5);
plot(x,LinearFit)

xlabel ('X - Janela de Tempo do sinal')
ylabel ('Y - Média da Amplitude')

%%%%1º Grau
%Equacao_FFT = (['Y = ' num2str(a(1)) ' * X + ' num2str(a(2))])
%%%%2ºGrau
%Equacao_FFT = (['Y = ' num2str(a(1)) ' * X^2 + ' num2str(a(2)) ' * X + ' num2str(a(3))])
%%%%3ºGrau
% Equacao_FFT = (['Y = ' num2str(a(1)) ' * X^3 + ' num2str(a(2)) ' * X^2 + ' num2str(a(3)) ' * X + ' num2str(a(4))])
%%%%4ºGrau
Equacao_FFT = (['Y = ' num2str(a(1)) ' * X^4 + ' num2str(a(2)) ' * X^3 + ' num2str(a(3)) ' * X^2 + ' num2str(a(4)) ' * X + ' num2str(a(5))])
Range_do_plot = axis;
text (Range_do_plot(2)/2,Range_do_plot(4)*.98,Equacao_FFT)

% % %-------------------Não obtive resultados satisfatorios.
% % %Frequencia Média por Média Ponderada
% % k=1;
% % %faz o produto escalar de cada linha da matriz_fft com as frequencias
% % while k <= size(matriz_fft,1)
% %     j=1;
% %     %Pega vetores da matriz
% %     while j <= size(matriz_fft,2)
% %         vetor_amplitude(j) = matriz_fft(k,j);
% %         j=j+1;
% %     end
% %     %Multiplica cada frequencia com sua amplitude
% %     Peso_Frequencia(k) = sum(dot(vetor_frequencia_grafico,vetor_amplitude));
% %     k=k+1;    
% % end
% % %acha as frequencias médias
% % Frequencia_Media = Peso_Frequencia/(sum(vetor_frequencia_grafico));
% % 
% % figure
% % plot(x,Frequencia_Media)
% % xlabel ('X - Janela de Tempo do sinal')
% % ylabel ('Y - Média Ponderada da Frequencia')

%BUG, POR ALGUM MOTIVO O Y ESTÁ SENDO MOSTRADO NO FIM DO PLOT
clear y