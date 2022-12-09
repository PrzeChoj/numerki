function [integral, points] = quasiMC_integrate(f, randPoints)

xs = faure(randPoints, 2, 2);
fs = f(xs(1,:), xs(2,:));

integral = sum(fs) / randPoints;
points = xs;

end % function