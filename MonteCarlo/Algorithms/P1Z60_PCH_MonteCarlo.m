function [integral] = P1Z60_PCH_MonteCarlo(f, randPoints, type, params)
% Projekt 1, zadanie 60
% Przemyslaw Chojecki, 298814
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
%                     wektor dlugosci 4 reprezentujacy parametry rozkladu
%                     Beta kolejno (alpha_1, beta_1, alpha_2, beta_2)
%                     (domyslnie (1,1,1,1))
%                  dla type = "divideAndConquer":
%                     liczba punktow użytych do estymacji wariancji
%                     w każdym kroku przed podzialem (domyslenie 10)
%                  dla type = "latinHypercube":
%                     liczba K, czyli skala rozlożonosci. Im wieksze K, tym
%                     rowniej rozlorzone sa punkty na kwadracie
%                     [0,1]x[0,1] (domyslenie 50)
% 
% Wyjscie:
%   integral - estymowana wartosc calki
% 
% Możliwe wartosci parametru type:
%  "basic"               - losowanie randPoints liczb jednostajnie z
%                          dziedziny i zastosowanie wzoru
%                          integral \approx (sum(f(x_i)))/randPoints
%  "quasiMC"             - uzycie deterministycznego ciagu Faure zamiast
%                          losowanych jednostajnie
%  "reimann"             - deterministyczne przybliżenie
%                          siatka (i/n, j/n)_(i,j), gdzie
%                          n = floor(sqrt(randPoints))
%  "imporftanceSampling" - losowanie punktow z kwadratu [0,1]x[0,1]
%                          nie rozkladem jednostajnym, a rozkladem
%                          Beta(alpha_1, beta_1) x Beta(alpha_2, beta_2),
%                          gdzie parametry rozkladu sa podane przez
%                          uzytkownika
%  "latinHypercube"      - uzycie metody Latin Hypercube Sampling,
%                          aby wziekszyc rozlozenie punktow.
%                          Używa parametru K (domyslenie 10)
%  "divideAndConquer"    - podziel obszar na 4 i wykonaj Conditional
%                          Sampling na każdej z czesci; optymalny podzial
%                          pozostalej czesci budzetu podzielona bedzie na
%                          podstawie wstepnej estymacji za pomoca
%                          dividePoints losowan w każdym fragmencie

switch type
    case "basic"
        integral = basic_integrate(f, randPoints);
    case "quasiMC"
        integral = quasiMC_integrate(f, randPoints);
    case "reimann"
        integral = reimann_integrate(f, randPoints);
    case "imporftanceSampling"
        integral = imporftanceSampling_integrate(f, randPoints, ...
                        params(1), params(2), params(3), params(4));
    case "latinHypercube"
        if ~exist('params','var')
            params = 50;
        end
        integral = latinHypercube_integrate(f, randPoints, params(1));
    case "divideAndConquer"
        if ~exist('params','var')
            params = 10;
        end
        integral = divideAndConquer_integrate(f, randPoints, params(1));
        
end % function