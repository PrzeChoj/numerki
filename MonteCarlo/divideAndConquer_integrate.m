function [integral] = divideAndConquer_integrate(f, randPoints, n_var_est)

integral = divideAndConquer_integrate_recurrent(f, ...
    randPoints, n_var_est, 0, 1, 0, 1);

end