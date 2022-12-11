function [integral, points] = divideAndConquer_integrate(f, randPoints, n_var_est)
% Projekt 1, zadanie 60
% Adam Przemyslaw Chojecki, 298814
%
% Oblicza wartosc calki zgodnie z opisem w funkcji P1Z60_PCH_MonteCarlo.
% Rownierz i tam opisane sa dane wejsciowe i wyjsciowe.

[integral, points] = divideAndConquer_integrate_recurrent(f, ...
    randPoints, n_var_est, 0, 1, 0, 1);

% points ma czasem wartosci 0; Trzeba sie tych zer pozbyc
non_zers = (points(1,:) ~= 0);
points_out = zeros(2,sum(non_zers));
points_out(1,:) = points(1,non_zers);
points_out(2,:) = points(2,non_zers);
points = points_out;

end % function