function [integral] = reimann_integrate(f, randPoints)

n = floor(sqrt(randPoints));

xs = [repelem((1:n)/n, n); repmat((1:n)/n, 1,n)];
fs = f(xs(1,:), xs(2,:));

integral = sum(fs) / randPoints;

end