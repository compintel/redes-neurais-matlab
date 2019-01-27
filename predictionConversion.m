%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	Esta fun��o gera atrasos e intervalos em s�ries temporais
%	
%	Autor: Rafael Hrasko (rhrasko@gmail.com)
%
%   Este c�digo � aberto para fins acad�micos, mas lembre-se, caso utilize:
%   d� cr�dito a quem merece cr�dito. Qualquer erro encontrado, por favor, 
%   reporte via e-mail para que possa corrigi-lo.
%   Fa�a bom uso =)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Como usar:
%   
%   nIN - retorna o n�mero de entradas
%   nOUT - devolve o numero de saidas
%   in - devolve a base de entrada ja atrasada e intervalada
%   out - devolve a sa�da

%   db - base de dados a ser atrasada e intervalada
%   nIN - n�mero de atrados desejados
%   delta - n�mero de intervalos desejados

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ nIN nOUT in out] = predictionConversion( db,nIN,delta )
nOUT = 1;
sizeDB = size(db,1);
n = sizeDB - (nIN*delta);

full = zeros(n,nIN+1);

for i=1:nIN+1
   t = 1 + (delta*(i-1));
   full(:,i) = db(t:n+t-1);
end
in = full(:,1:nIN);
out = full(:,nIN+1);

end
