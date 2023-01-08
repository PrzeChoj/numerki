function [] = test1()
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
%
% Sprawdza poprawnosc implementacji na przykladach
% rzeczywistych jak i zespolonych.

disp("Test sprawdza poprawnosc funkcji pomocniczych oraz")
disp("funkcji glownej na przykladowych danych")

disp(" ")
disp("Warto zauwazyc, ze MATLAB-owa funkcja hess() zwraca")
disp("szczegolny przypadek macierzy Hessenberga z polecenia,")
disp("gdzie na poddiagonali sa liczby rzeczywiste.")

disp("========================================================")
input("")
disp("Wartosci wlasne macierzy 2x2")
disp("Policzenie wartosci wlasnych losowej macierzy 2x2:")
rng(1)
A = complex(rand(2), rand(2));
[eigs] = my_eigen(A);
disp("Przez MATLABowa funkcje eig():")
disp(eig(A))
disp("Przez zaimplementowana funkcje my_eigen():")
disp(eigs.')
disp("Widzimy, ze sa one takie same.")

input("");

disp("Sprawdzmy poprawnosc na wielu losowych " + ...
    "macierzach, a nie tylko na jednej:")

wszystkie_ok = true;
for i=1:1000
    A = complex(rand(2), rand(2));
    if ~are_eigenvalues_equal(eig(A), my_eigen(A).')
        wszystkie_ok = false;
    end
end

if wszystkie_ok
    disp("Wszystkie 1000 macierzy daly poprawny wynik.")
else
    disp("Ktoras z 1000 macierzy dala niepoprawny wynik.")
end

disp("========================================================")
input("")
disp("Rozklad macierzy na qr przy pomocy obrotow Givensa,")
disp("czyli poprawnosc funkcji qr_Givens()")

n = 50;
A = complex(rand(n), rand(n));
for i = 3:n
    for j = 1:i-2
        A(i,j) = 0; % Hessenbergizacja macierzy A
    end
end
[c, s, R] = qr_Givens(A);
disp(" ")
disp("Wywolano [c, s, R] = qr_Givens(A) na losowej zespolonej " + ...
    "macierzy Hessenberga A wymiaru 50x50.")
disp(" ")
disp("Czy c i s sa odpowiednie? Sprawdzmy jedynke trygonometryczna:")
my_s = string(abs(c).^2 + abs(s).^2);
my_str = "abs(c).^2 + abs(s).^2 = [";
for i=1:(n-2)
    if i == 21
        my_str = my_str + newline;
    end
    my_str = my_str + my_s(i) + ", ";
end
my_str = my_str + my_s(49);
disp(my_str + "].")
input("")
disp("Czy A = Q*R?")
[A_test, B_test] = iloczyn_test(c, s, R);
disp("norm(A - Q*R) = ")
disp(norm(A - A_test));
input("")
disp("Czy iteracja algorytmu QR zmienila wartosci wlasne?")
if are_eigenvalues_equal(eig(A), eig(B_test))
    disp("eig(A) = eig(R*Q) jako zbiory")
else
    disp("eig(A) ~= eig(R*Q) jako zbiory")
end

disp("========================================================")
input("");
disp("Poprawnosc funkcji glownej")
disp(" ")
disp("Wywolano funcke glowna szukajaca wartosci wlasnych ")
disp("na losowej zespolonej macierzy Hessenberga wymiaru 50x50.")
disp("(okolo 2 sekundy obliczen)")

n = 50;
A = complex(rand(n), rand(n));

for i = 3:n
    for j = 1:i-2
        A(i,j) = 0;
    end
end

matlab_eigs = eig(A);
my_eigs = P2Z55_PCH_HessenQR(A, 10000).'; % n=[50, 100] -> [3, 11] sekund
input("")
if are_eigenvalues_equal(matlab_eigs, my_eigs)
    disp("eig(A) znalazl te same wartosci wlasne, co P2Z55_PCH_HessenQR()")
else
    disp("eig(A) znalazl INNE wartosci wlasne od P2Z55_PCH_HessenQR()")
end

end % function