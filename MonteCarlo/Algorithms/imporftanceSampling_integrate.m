function [integral, points] = imporftanceSampling_integrate(f, ...
    randPoints, alpha_1, beta_1, alpha_2, beta_2)

ys(1,:) = betarnd(alpha_1, beta_1, 1, randPoints);
ys(2,:) = betarnd(alpha_2, beta_2, 1, randPoints);

fs = f(ys(1,:), ys(2,:));
g1 = betapdf(ys(1,:), alpha_1, beta_1);
g2 = betapdf(ys(2,:), alpha_2, beta_2);

integral = sum(fs ./ g1 ./ g2) / randPoints;
points = ys;

end % function