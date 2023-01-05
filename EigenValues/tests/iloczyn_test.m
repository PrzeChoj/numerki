function [A, B] = iloczyn_test(c, s, R)
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
%
% Oblicza iloczyny A = Q * R oraz B = R * Q,
% gdzie macierz Q zapisana jest jako wektory c i s
% Czyli odwraca działanie funkcj qr_Givens oraz sprawdza iloczyn

n = size(c, 2) + 1;
Q = eye(n);

for i=1:(n-1)
    Q_i = eye(n);
    Q_i(i,i) = c(i);
    Q_i(i,i+1) = -s(i);
    Q_i(i+1,i) = conj(s(i));
    Q_i(i+1,i+1) = conj(c(i));

    Q = Q*Q_i;
end

A = Q*R;
B = R*Q;

end