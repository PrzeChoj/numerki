function [] = test3()
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
%
% Sprawdza dzialanie algorytmu dla macierzy permutacji cyklu (1,2,...,n)

disp("Test sprawdza dzialanie funkcji na macierzy permutacji")
disp("cyklu (1,2,3,...,n), ktora jest macierza Hessenberga i")
disp("wszystkie jej wartosci wlasne maja modul rowny 1.")

disp("========================================================")
input("")
disp("Na poczatek sprawdzmy dla najmniejszego sensownego n = 3")

n = 3;
A = zeros(n,n);
for i=1:n-1
    A(i+1,i) = 1;
end
A(1,n) = 1;

matlab_eigs = eig(A);
disp("Prawdziwymi wartosciami wlasnymi sa [" + matlab_eigs(1) + ", " + ...
    matlab_eigs(2) + ", " + matlab_eigs(3) + "].")
my_eigs = P2Z55_PCH_HessenQR(A, 10000)';
if size(my_eigs, 1) ~= 0
    error("Znalezniono jakas wartosc wlasna, to nie powinno byc mozliwe!")
end
disp("Zadna wartosc wlasna nie zostala znaleziona.")
disp(" ")
[c, s, R] = qr_Givens(A);
disp("Nie jest to zaskakujace, gdyz obroty Givensa dla tej macierzy")
disp("sa bardzo szczegolnej postaci, gdzie c = [" + c(1) + ", " + ...
    c(2) + "], s = [" + s(1) + ", " + s(2) + "],")
if ~all(all(R == eye(3)))
    error("R ~= eye(3), to nie powinno byc mozliwe!")
end
disp("natomiast macierz gornotrojkatna jest rowna jednostkowej.")
disp(" ")
disp("W praktyce oznacza to, że A = Q*R = R*Q,")
disp("wiec algorytm QR nie może zbiec.")

end % function