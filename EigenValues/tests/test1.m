function [] = test1()
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
%
% Sprawdza poprawnosc implementacji na przykladach
% rzeczywistych jak i zespolonych.

rng(1)
n = 50;
A = complex(rand(n), rand(n));

for i = 3:n
    for j = 1:i-2
        A(i,j) = 0;
    end
end

matlab_eigs = eig(A);
tic;
my_eigs = P2Z55_PCH_HessenQR(A, 10000).'; % n=[50, 100] -> [1.5, 11] sekund
toc;
are_eigenvalues_equal(matlab_eigs, my_eigs)

%input();

% całkowite, zespolone:
rng(1)

n = 3;
A = complex(randi(5, n), randi(5, n));

for i = 3:n
    for j = 1:i-2
        A(i,j) = 0;
    end
end

matlab_eigs = eig(A);
my_eigs = P2Z55_PCH_HessenQR(A, 2000).';
are_eigenvalues_equal(matlab_eigs, my_eigs)




