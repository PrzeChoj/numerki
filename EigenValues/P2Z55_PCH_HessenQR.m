function [w_wlasne] = P2Z55_PCH_HessenQR(A, eps_a, eps_zesp, max_iter)
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
%   eps_a        - tolerancja na akceptacje rzeczywistej wartosci wlasnej,
%                  domyslnie 10^-10
%   eps_zesp     - tolerancja na akceptacje zespolonej wartosci wlasnej,
%                  domyslnie 10^-10
%   max_iter     - maksymalna liczba iteracji, po ktorej przekroczeniu
%                  obliczenia zostana przerwane
%                  domyslnie 1000
%
% Wyjscie:
%   w_wlasne - wektor wektorow wlasnych macierzy A
%
% Pseudokod algorytmu:
%   1. Macierz A_1 = A jest postaci Hessenberga
%   2. n = size(A, 1); w_wlasne = zeros(1,n)
%   3. For k = 1:max_iter
%       a) Macierz A_k jest postaci Hessenberga
%       b) [Q, R] = qr_Givens(A_k)
%       c) A_{k+1} = R * Q
%       d) Jesli |A_{k+1}(n,n-1)| < eps_a:
%           * w_wlasne(n) = A_{k+1}(n,n)
%           * n = n-1 % jesli n == 0, koniec
%           * A_{k+1} = A_{k+1}(1:n,1:n)         % albo to?
%           * A_{1} = A_{k+1}(1:n,1:n); k = 1;   % albo to?
%       e) Jesli |A_{k+1}(n-1,n-2)| < eps_zesp:
%           * w_wlasne(n-1, n) = my_eigen(A_{k+1}(n-1:n,n-1:n)) % to beda
%                                                                 zespolone
%           * n = n-2 % jesli n == 0, koniec
%           * A_{k+1} = A_{k+1}(1:n,1:n)         % albo to?
%           * A_{1} = A_{k+1}(1:n,1:n); k = 1;   % albo to?
%   4. Teraz w_wlasne to wektor wartosci wlasnych macierzy A
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