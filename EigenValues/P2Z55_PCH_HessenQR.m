function [w_wlasne] = P2Z55_PCH_HessenQR(A, eps_1, eps_2, max_iter)
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
%
% Algorytm liczenia wartosci wlasnych macierzy Hessenberga A.
% 
% Odbywa sie to za pomoca algorytmu QR, w ktorym macierz jest iteracyjnie
% rozkladana A_k = QR, gdzie Q to macierz ortogonalna (Q^(-1) = Q^T), a
% R jest macierza trojkatna gorna, a nastepnie mnozona w odwrotnej
% kolejnosci A_{k+1} = RQ.
% 
% Macierze Q oraz R znajdywane sa przy pomocy obrotow Givensa.
%
% Wejscie:
%   A            - macierz Hessenberga
%   eps_1        - tolerancja na akceptacje pojedynczej wartosci wlasnej,
%                  domyslnie 10^{-10}
%   eps_2        - tolerancja na akceptacje 2 bliskich co do modułu
%                  wartosci wlasnych, domyslnie 10^{-10}
%   max_iter     - maksymalna liczba iteracji, po ktorej przekroczeniu
%                  obliczenia zostana przerwane
%                  domyslnie 1000
%
% Wyjscie:
%   w_wlasne - wektor wartosci wlasnych macierzy A
%
% Pseudokod algorytmu:
%   1. Macierz A_1 = A jest postaci Hessenberga
%   2. n = size(A, 1); w_wlasne = zeros(1,n); k = 1
%   3. while k <= max_iter
%       a) Macierz A_k jest postaci Hessenberga
%       b) [Q, R] = qr_Givens(A_k)
%       c) k = k + 1
%       d) A_{k} = iloczyn(R, Q)
%       e) Jesli |A_{k}(n,n-1)| < eps_1:
%           * w_wlasne(n) = A_{k}(n,n)
%           * A_{1} = A_{k}(1:n,1:n)
%           * n = n-1
%           * jesli n == 2, przejdź do 5
%           * k = 1
%       f) Jesli |A_{k}(n-1,n-2)| < eps_2 * |A_{k}(n,n-1)|:
%           * w_wlasne(n-1, n) = my_eigen(A_{k}(n-1:n,n-1:n))
%           * A_{1} = A_{k}(1:n,1:n)
%           * n = n-2
%           * jesli n == 1 albo n == 2, przejdź do 5
%           * k = 1
%   4. Jeśli k == max_iter, zwroc w_wlasne(n+1, size(A, 1)),
%       ta czyli czesc wartosci wlasnych, ktore udalo sie znalesc
%   5. Teraz n == 1 albo n == 2
%   6. w_wlasne(n-1, n) = my_eigen(A_{1}) albo w_wlasne(n) = A_{1}
%   7. Teraz w_wlasne to wektor wartosci wlasnych macierzy A
% 
% Nalezy oczywiscie zaznaczyc, ze funkcja qr_Givens z punktu 3b nie bedzie
%   zwracac macierzy Q jako obiekt "matrix" w MATLABie, tylko w innej,
%   oszczednej pamieciowo formie. Podobnie mnozenie w 3c bedzie wykonane
%   odpowiednio optymalnie za posrednictwem wlasnej funkcji.
% Sam podział przy pomocy qr_Givens jest rzędu o(n^2), czyli lepiej niż
%   ogólny algorytm qr, który jest rzędu o(n^3).
% 

n = size(A, 1);
w_wlasne = zeros(1, n);

end % function