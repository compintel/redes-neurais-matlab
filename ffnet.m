%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	Redes Neurais Artificiais - Toolbox MATLAB
%	
%	Autor: André Pacheco (pacheco.comp@gmail.com)
%   Este arquivo utiliza a toolbox de RNA do MATLAB para executar a
%   predição de uma série temporal
%   Para utilizar basta chamar o script na linha de comando do MATLAB
%   ou simplesmente executar com atalho F5
%
%   Este código é aberto para fins acadêmicos, mas lembre-se, caso utilize:
%   dê crédito a quem merece crédito. Qualquer erro encontrado, por favor, 
%   reporte via e-mail para que possa corrigi-lo.
%   Faça bom uso =)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Carregando a série temporal de produção mensal de energia
% elétrica na Australia. A série contém dados de Janeiro de 1956 até
% Agosto de 1995. Os dados estão em Gwh
energy_aus = dlmread ('energy_aus.txt');

% Para realizar uma boa predição a entrada do preditor deve estar atrasada
% e intervalada. Sem entrar em detalhes (não é o foco aqui) a função abaixo realiza tal
% processo, sendo o atraso igual a 8 e o intervalo igual a 4.

[nIN nOUT energy_aus_IN_84 energy_aus_OUT_84] = predictionConversion(energy_aus,8,4);


%Apenas renomeando os dados de entrada e saída
dataIN = energy_aus_IN_84;
dataOUT = energy_aus_OUT_84;

% Normalmente em predição e/ou classificação são utilizados 70% da base de
% dados para treino e 30% para teste. Isso será feito aqui.

% Obtendo tamanho da base e o tamanho de 70% dela
tam = length (dataIN);
tam70 = round(0.7*tam);

% Obtendo os dados de 70% da base tanto para saída quanto para entrada
dataIN_70 = dataIN (1:tam70,:);
dataOUT_70 = dataOUT (1:tam70,:);

% Obtendo 30% para teste da base tanto para saída quanto para entrada
dataIN_30 = dataIN (tam70:tam,:)';
dataOUT_30 = dataOUT (tam70:tam,:)';

% Obtendo a transposta dos dados. Isso é feito para adequar o formato dos
% dados com a função de RNA do MATLAB. Só coloquei aqui para não ser uma 
% parte oculta. Veja no tutorial o padrão de entrada da toolbox.
dataIN_70 = dataIN_70';
dataOUT_70 = dataOUT_70';


% Utilização da toolbox de fato. Inicializando e configurando a rede
% com 2 camadas ocultas com 100 e 50 neurônios respectivamente.
net = feedforwardnet([100 50]); 
net = configure(net,dataIN_70,dataOUT_70); 

%Definindo as funções de ativação. Nesse caso, sigmóid.
net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'logsig';

% Realizando o treinamento da rede com a toolbox
[net,tr] = train(net,dataIN_70,dataOUT_70);

% Neste ponto a rede já está treinada. Os próximos passos são executar para
% os 30% de dados da série e plotar o resultado. 

% Plotando, em azul, toda a série real
plot (1:tam,dataOUT,'b');
hold on;

% Executando a rede para os 30% de dados que não foram utilizados no
% treinamento
out = net(dataIN_30); 

% Plotando, em vermelho, os dados de execução em cima da série real para
% comparação
plot (tam70:tam,out,'r'); % plotando os dados de treinamento e de teste
legend ('Dados real','Dados da RNA');



