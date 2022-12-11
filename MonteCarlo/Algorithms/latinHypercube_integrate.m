function [integral, points] = latinHypercube_integrate(f, randPoints, K)
% Projekt 1, zadanie 60
% Adam Przemyslaw Chojecki, 298814
%
% Oblicza wartosc calki zgodnie z opisem w funkcji P1Z60_PCH_MonteCarlo.
% Rownierz i tam opisane sa dane wejsciowe i wyjsciowe.
%
% Parametr wejsciowy K mowi jak wiele punktow obok siebie
% bedzie skorelowanych. Im wartosc wieksza, tym punkty
% beda rowniej rozlozone na kwadracie [0,1]x[0,1].
%
% Na podstawie strony 361 z ksiazki Handbook of MC methods autorstwa
% Dirk P. Kroese, Thomas Taimre, oraz Zdravko I. Botev

N = floor(randPoints/K);
points = zeros(2, N*K);
integral = 0;

for n=1:N
    us = rand(2,K);
    [~,p] = sort(rand(K,2));
    V = (p' - us)/K; % bez + 1
    points(:, ((n-1)*K + 1):(n*K)) = V;
    integral = integral + sum(f(V(1,:), V(2,:)))/K;
end

integral = integral/N;

end % function