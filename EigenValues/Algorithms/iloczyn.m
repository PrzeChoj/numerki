function [A] = iloczyn(R, c, s)
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
%
% Oblicza iloczyn R * Q, gdzie macierz Q zapisana jest jako wektory c i s

n = size(R, 1);
for k = 1:(n-1)
    [R(1:k+1, k), R(1:k+1, k+1)] = apply_givens_rotation(c(k), conj(s(k)), R(1:k+1, k), R(1:k+1, k+1));
end

A = R;

end % function