%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	Redes Neurais Artificiais - Toolbox MATLAB
%	
%	Autor: Andr� Pacheco (pacheco.comp@gmail.com)
%   Este arquivo utiliza a toolbox de RNA do MATLAB para executar a
%   predi��o de uma s�rie temporal
%   Para utilizar basta chamar o script na linha de comando do MATLAB
%   ou simplesmente executar com atalho F5
%
%   Este c�digo � aberto para fins acad�micos, mas lembre-se, caso utilize:
%   d� cr�dito a quem merece cr�dito. Qualquer erro encontrado, por favor, 
%   reporte via e-mail para que possa corrigi-lo.
%   Fa�a bom uso =)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Carregando a s�rie temporal de produ��o mensal de energia
% el�trica na Australia. A s�rie cont�m dados de Janeiro de 1956 at�
% Agosto de 1995. Os dados est�o em Gwh
energy_aus = dlmread ('energy_aus.txt');

% Para realizar uma boa predi��o a entrada do preditor deve estar atrasada
% e intervalada. Sem entrar em detalhes (n�o � o foco aqui) a fun��o abaixo realiza tal
% processo, sendo o atraso igual a 8 e o intervalo igual a 4.

[nIN nOUT energy_aus_IN_84 energy_aus_OUT_84] = predictionConversion(energy_aus,8,4);


%Apenas renomeando os dados de entrada e sa�da
dataIN = energy_aus_IN_84;
dataOUT = energy_aus_OUT_84;

% Normalmente em predi��o e/ou classifica��o s�o utilizados 70% da base de
% dados para treino e 30% para teste. Isso ser� feito aqui.

% Obtendo tamanho da base e o tamanho de 70% dela
tam = length (dataIN);
tam70 = round(0.7*tam);

% Obtendo os dados de 70% da base tanto para sa�da quanto para entrada
dataIN_70 = dataIN (1:tam70,:);
dataOUT_70 = dataOUT (1:tam70,:);

% Obtendo 30% para teste da base tanto para sa�da quanto para entrada
dataIN_30 = dataIN (tam70:tam,:)';
dataOUT_30 = dataOUT (tam70:tam,:)';

% Obtendo a transposta dos dados. Isso � feito para adequar o formato dos
% dados com a fun��o de RNA do MATLAB. S� coloquei aqui para n�o ser uma 
% parte oculta. Veja no tutorial o padr�o de entrada da toolbox.
dataIN_70 = dataIN_70';
dataOUT_70 = dataOUT_70';


% Utiliza��o da toolbox de fato. Inicializando e configurando a rede
% com 2 camadas ocultas com 100 e 50 neur�nios respectivamente.
net = feedforwardnet([100 50]); 
net = configure(net,dataIN_70,dataOUT_70); 

%Definindo as fun��es de ativa��o. Nesse caso, sigm�id.
net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'logsig';

% Realizando o treinamento da rede com a toolbox
[net,tr] = train(net,dataIN_70,dataOUT_70);

% Neste ponto a rede j� est� treinada. Os pr�ximos passos s�o executar para
% os 30% de dados da s�rie e plotar o resultado. 

% Plotando, em azul, toda a s�rie real
plot (1:tam,dataOUT,'b');
hold on;

% Executando a rede para os 30% de dados que n�o foram utilizados no
% treinamento
out = net(dataIN_30); 

% Plotando, em vermelho, os dados de execu��o em cima da s�rie real para
% compara��o
plot (tam70:tam,out,'r'); % plotando os dados de treinamento e de teste
legend ('Dados real','Dados da RNA');



