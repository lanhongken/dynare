function [Ui,Vi,n0,np,ixmC0Pres] = upper_cholesky(nvar,nexo,options_ms)

lags = options_ms.nlags;
indxC0Pres = options_ms.cross_restrictions;

Ui = cell(nvar,1);
Vi = cell(nvar,1);
n0 = zeros(nvar,1);
np = zeros(nvar,1);

if (nargin==2)
   nexo = 1;
elseif (nargin==3)
   indxC0Pres = 0;
end

k = lags*nvar+nexo;
Qi = zeros(nvar,nvar,nvar);
Ri = zeros(k,k,nvar);

for ii=2:nvar
  Qi(ii-1,ii-1,ii)=1;
  Qi(:,:,ii)=Qi(:,:,ii)+Qi(:,:,ii-1);
end

if options_ms.constants_exclusion
    for i=1:nvar
        Ri(i,k,i) = 1;
    end
end

for n=1:nvar 
   Ui{n} = null(Qi(:,:,n));
   Vi{n} = null(Ri(:,:,n));
   n0(n) = size(Ui{n},2);
   np(n) = size(Vi{n},2);
end

ixmC0Pres = NaN;