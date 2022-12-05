function [integral] = latinHypercube_integrate(f, randPoints, K)
% Based on page 361 of Handbook of MC methods by
% Dirk P. Kroese, Thomas Taimre, and Zdravko I. Botev

N = floor(randPoints/K);
integral = 0;

for n=1:N
    us = rand(2,K);
    [~,p] = sort(rand(K,2));
    V = (p' - us)/K; % bez + 1
    integral = integral + sum(f(V(1,:), V(2,:))) / K;
end

integral = integral/N;

end % function