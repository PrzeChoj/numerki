function [ciA,vicA] = cmatgen(n,d,w)
%Tworzenie macierzy ciA o wymiarach n x d
%Elementy macierzy A oddalone od przekątnej o wartość <= w
%WARUNEK w>=d-1
%Tworzenie dominującej wierszowo macierzy vicA o wymiarach n x d
%UWAGA działa długo (dla rozmiaru powyżej 1mln x 50 nie przekraczać w=500)
tic

%Generowanie ciA
ciA(1:n,1) = 1:n;
for i = 1:n
    notx = [max(1,i-w):i-1 i+1:min(n,w+i)];
    ciA(i,2:d) = notx(randperm(numel(notx),d-1));
end

%Generowanie vicA
vicA(1:n,2:d) = randn(n,d-1);
vicA(1:n,1) = (1+rand)*sum(abs(vicA(1:n,2:d)),2);
posNegShuffle = round(rand(n,1));
posNegShuffle(posNegShuffle==0) = -1;
vicA(1:n,1) = vicA(1:n,1).*posNegShuffle;

%Sortowanie indeksów w ciA i vicA

sortIndex = repmat(1:d,n,1);
[ciA,sortIndex] = sort(ciA,2);
for i = 1:n
    vicA(i,:) = vicA(i,sortIndex(i,:));
end