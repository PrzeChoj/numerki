function [integral, points] = P1Z60_PCH_MonteCarlo(f, randPoints, type, params)
% Projekt 1, zadanie 60
% Adam Przemyslaw Chojecki, 298814
% 
% Obliczanie calki podwojnej metodami
% Monte Carlo na kwadracie [0,1]x[0,1].
% 
% Wejscie:
%   f            - uchwyt do funkcji 2 zmiennych, ktora bedzie calkowana
%   randPoints   - liczba iteracji metody (domyslenie 10000)
%   type         - rodzaj calkowania (opisane ponizej);
%                  (domyslenie "basic"); jedno z: "basic",
%                  "quasiMC", "reimann", "imporftanceSampling",
%                  "latinHypercube", "divideAndConquer"
%   params       - dla type = "imporftanceSampling":
%                     wektor dlugosci 4 reprezentujący parametry rozkladu
%                     Beta kolejno (alpha_1, beta_1, alpha_2, beta_2)
%                     (domyslnie (1,1,1,1))
%                  dla type = "divideAndConquer":
%                     liczba punktów użytych do estymacji wariancji
%                     w każdym kroku przed podziałem (domyslenie 10)
%                  dla type = "latinHypercube":
%                     liczba K, czyli skala rozlozonosci. Im większe K,
%                     tym rowniej rozlorzone są punkty na kwadracie
%                     [0,1]x[0,1] (domyslenie 50)
% 
% Wyjscie:
%   integral - estymowana wartosc calki
%   points   - lista punktów użytych do estymacji całki
% 
% Możliwe wartości parametru type:
%  "basic"               - losowanie randPoints liczb jednostajnie z
%                          dziedziny i zastosowanie wzoru
%                          integral \approx (sum(f(x_i)))/randPoints
%  "quasiMC"             - uzycie deterministycznego ciagu Faure zamiast
%                          losowanych jednostajnie
%  "reimann"             - deterministyczne przyblizenie
%                          siatką (i/n, j/n)_(i,j), gdzie
%                          n = floor(sqrt(randPoints))
%  "imporftanceSampling" - losowanie punktów z kwadratu [0,1]x[0,1]
%                          nie rozkladem jednostajnym, a rozkladem
%                          Beta(alpha_1, beta_1) x Beta(alpha_2, beta_2),
%                          gdzie parametry rozkladu sa podane przez
%                          uzytkownika
%  "latinHypercube"      - uzycie metody Latin Hypercube Sampling,
%                          aby wziekszyc rozlozenie punktow.
%                          Używa parametru K (domyslenie 10)
%  "divideAndConquer"    - podziel obszar na 4 i wykonaj Conditional
%                          Sampling na każdej z części; optymalny podzial
%                          pozostalej czesci budzetu podzielona bedzie na
%                          podstawie wstepnej estymacji za pomocą
%                          dividePoints losowań w każdym fragmencie

switch type
    case "basic"
        [integral, points] = basic_integrate(f, randPoints);
    case "quasiMC"
        [integral, points] = quasiMC_integrate(f, randPoints);
    case "reimann"
        [integral, points] = reimann_integrate(f, randPoints);
    case "imporftanceSampling"
        [integral, points] = imporftanceSampling_integrate(f, ...
            randPoints, params(1), params(2), params(3), params(4));
    case "latinHypercube"
        if ~exist('params','var')
            params = 50;
        end
        [integral, points] = latinHypercube_integrate(f, randPoints, params(1));
    case "divideAndConquer"
        if ~exist('params','var')
            params = 10;
        end
        [integral, points] = divideAndConquer_integrate(f, randPoints, params(1));
        
end % function