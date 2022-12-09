function [integral, points] = basic_integrate(f, randPoints)

xs = rand(2,randPoints);
fs = f(xs(1,:), xs(2,:));

integral = sum(fs) / randPoints;
points = xs;

end % function