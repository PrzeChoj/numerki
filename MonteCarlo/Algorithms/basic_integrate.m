function [integral] = basic_integrate(f, randPoints)

xs = rand(2,randPoints);
fs = f(xs(1,:), xs(2,:));

integral = sum(fs) / randPoints;

end % function