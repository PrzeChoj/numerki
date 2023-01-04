function [] = test1()
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
%
% Sprawdza poprawnosc implementacji na przykladach rzeczywistych jak i
% zespolonych.

n = 10;
A = complex(rand(n), rand(n));
A = rand(n);

for i = 3:n
    for j = 1:i-2
        A(i,j) = 0;
    end
end

eig(A)
P2Z55_PCH_HessenQR(A)'