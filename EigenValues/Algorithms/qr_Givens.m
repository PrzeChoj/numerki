function [c, s, R] = qr_Givens(A)
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
%
% Funkcja oblicza rozklad macierzy A = QR
% 
% Rozklad obliczany jest przy pomocy obrotow Givensa.

H = A;

[n, ~] = size(H);
Q = eye(n);
c = zeros(1, n-1);
s = zeros(1, n-1);

for j = 1:(n-1)
    [H(j,j), H(j+1,j), c(j), s(j)] = givens_rotation(H(j,j), H(j+1,j));
    [H(j,j+1:n), H(j+1,j+1:n)] = apply_givens_rotation(c(j), s(j), H(j,j+1:n), H(j+1,j+1:n));
end

R = H;

end