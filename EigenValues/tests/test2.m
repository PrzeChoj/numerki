function [] = test2()
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
%
% Sprawdza dzialanie algorytmu gdy jest wiecej niz 2 wartosci wlasne
% bliskie co do modulu

rng(1)

n = 6;
U = rand(n);
U = U*U';
A = U*diag([rand(1, n-4),1,1,1,1])*(U)^(-1);
H = hess(A);

eig(H)
P2Z55_PCH_HessenQR(H)'
are_eigenvalues_equal(eig(H), P2Z55_PCH_HessenQR(H)')
% gdy rzeczywiste, to sobie poradzil

n = 6;
U = rand(n);
U = U*U';
A = U*diag([rand(1, n-3),1,1i,-1i])*(U)^(-1);
H = hess(A);

eig(H)
P2Z55_PCH_HessenQR(H)'
are_eigenvalues_equal(eig(H), P2Z55_PCH_HessenQR(H)')
% gdy zespolone, to sobie nie poradzil
