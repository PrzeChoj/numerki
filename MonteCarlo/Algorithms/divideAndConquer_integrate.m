function [integral, points] = divideAndConquer_integrate(f, randPoints, n_var_est)

[integral, points] = divideAndConquer_integrate_recurrent(f, ...
    randPoints, n_var_est, 0, 1, 0, 1);

% points ma czasem 0; Trzeba się tych zer pozbyć
non_zers = (points(1,:) ~= 0);
points_out = zeros(2,sum(non_zers));
points_out(1,:) = points(1,non_zers);
points_out(2,:) = points(2,non_zers);
points = points_out;

end % function