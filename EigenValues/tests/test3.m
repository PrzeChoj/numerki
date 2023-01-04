function [] = test3()
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
%
% Sprawdza dzialanie algorytmu dla macierzy permutacji cyklu (1,2,...,n)

n = 6;
A = zeros(n,n);
for i=1:n-1
    A(i+1,i) = 1;
end
A(1,n) = 1;

eig(A)
out_alg = P2Z55_PCH_HessenQR(A, 100000)' % 5 sekund
are_eigenvalues_equal(eig(A), out_alg)
% absolutnie sobie nie poradzil mimo duzej ilosci iteracji