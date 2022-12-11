function [integral, points] = basic_integrate(f, randPoints)
% Projekt 1, zadanie 60
% Adam Przemyslaw Chojecki, 298814
% 
% Oblicza wartosc calki zgodnie z opisem w funkcji P1Z60_PCH_MonteCarlo.
% Rownierz i tam opisane sa dane wejsciowe i wyjsciowe.

xs = rand(2,randPoints);
fs = f(xs(1,:), xs(2,:));

integral = sum(fs) / randPoints;
points = xs;

end % function