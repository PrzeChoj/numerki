function [integral, points] = divideAndConquer_integrate(f, randPoints, n_var_est)

[integral, points] = divideAndConquer_integrate_recurrent(f, ...
    randPoints, n_var_est, 0, 1, 0, 1);

% TODO(delete zeros in points)

end % function