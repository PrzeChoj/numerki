function [eigs] = my_eigen(A)
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
% 
% Funkcja dostaje macierz wielkosci 2x2
%   i zwraca obie wartosci wlasne tej macierzy

p = A(1,1) * A(2,2) - A(1,2) * A(2,1); % Wyznacznik
m = (A(1,1) + A(2,2)) / 2;
s = sqrt(m*m - p);

eigs = [m + s, m - s];

end