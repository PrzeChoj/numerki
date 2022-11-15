function [integral] = P1Z60_PCH_MonteCarlo(f, randPoints, type, betaParams, dividePoints)
% Projekt 1, zadanie 60
% Przemyslaw Chojecki, 298814
% 
% Obliczanie całki podwójnej metodami Monte Carlo
% na kwadracie [0,1]x[0,1].
% 
% Wejscie:
%   f            - uchwyt do funkcji 2 zmiennych, ktora bedzie calkowana
%   randPoints   - liczba iteracji metody (domyslenie 10000)
%   type         - rodzaj całkowania (opisane ponizej);
%                  (domyslenie "basic"); jedno z: "basic",
%                  "quasiMC", "reimann", "imporftanceSampling",
%                  "latinHypercube", "divideAndConquer"
%   betaParams   - sprawdzany jedynie dla type = "imporftanceSampling";
%                  wektor długości 4 reprezentujący parametry rozkładu
%                  Beta kolejno (alpha_1, beta_1, alpha_2, beta_2)
%                  (domyslnie (1,1,1,1))
%   dividePoints - sprawdzany jedynie dla type = "divideAndConquer";
%                  liczba punktów użytych do estymacji wariancji
%                  w każdym kroku przed podziałem (domyslenie 10)
% 
% Wyjscie:
%   integral - estymowana wartosc calki
% 
% Możliwe wartości parametru type:
%  "basic"               - losowanie randPoints liczb jednostajnie z
%                          dziedziny i zastosowanie wzoru
%                          integral \approx (sum(f(x_i)))/randPoints
%  "quasiMC"             - uzycie deterministycznego ciągu Faure zamiast
%                          losowanych jednostajnie
%  "reimann"             - deterministyczne przybliżenie
%                          siatką (i/n, j/n)_(i,j), gdzie
%                          n = floor(sqrt(randPoints))
%  "imporftanceSampling" - losowanie punktów z kwadratu [0,1]x[0,1]
%                          nie rozkladem jednostajnym, a rozkladem
%                          Beta(alpha_1, beta_1) x Beta(alpha_2, beta_2),
%                          gdzie parametry rozkladu sa podane przez
%                          uzytkownika
%  "latinHypercube"      - uzycie metody Latin Hypercube Sampling,
%                          aby wziekszyc rozlozenie punktow
%  "divideAndConquer"    - podziel obszar na 4 i wykonaj Conditional
%                          Sampling na każdej z części; optymalny podzial
%                          pozostalej czesci budzetu podzielona bedzie na
%                          podstawie wstepnej estymacji za pomocą
%                          dividePoints losowań w każdym fragmencie

integral = 0;

end