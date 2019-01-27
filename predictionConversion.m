%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	Esta função gera atrasos e intervalos em séries temporais
%	
%	Autor: Rafael Hrasko (rhrasko@gmail.com)
%
%   Este código é aberto para fins acadêmicos, mas lembre-se, caso utilize:
%   dê crédito a quem merece crédito. Qualquer erro encontrado, por favor, 
%   reporte via e-mail para que possa corrigi-lo.
%   Faça bom uso =)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Como usar:
%   
%   nIN - retorna o número de entradas
%   nOUT - devolve o numero de saidas
%   in - devolve a base de entrada ja atrasada e intervalada
%   out - devolve a saída

%   db - base de dados a ser atrasada e intervalada
%   nIN - número de atrados desejados
%   delta - número de intervalos desejados

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
