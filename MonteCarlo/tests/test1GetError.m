function [err, my_time] = test1GetError(my_f, randPoints, integralAccurate)

my_time = zeros(1,6);
err = zeros(1,6);

tic;
err(1) = abs(P1Z60_PCH_MonteCarlo(my_f, randPoints, ...
    "basic") - integralAccurate);
my_time(1) = toc;
tic;
err(2) = abs(P1Z60_PCH_MonteCarlo(my_f, randPoints, ...
    "quasiMC") - integralAccurate);
my_time(2) = toc;
tic;
err(3) = abs(P1Z60_PCH_MonteCarlo(my_f, randPoints, ...
    "reimann") - integralAccurate);
my_time(3) = toc;
tic;
err(4) = abs(P1Z60_PCH_MonteCarlo(my_f, randPoints, ...
    "imporftanceSampling", [1.2,1,2,1]) - integralAccurate);
my_time(4) = toc;
tic;
err(5) = abs(P1Z60_PCH_MonteCarlo(my_f, randPoints, ...
    "latinHypercube") - integralAccurate);
my_time(5) = toc;
tic;
err(6) = abs(P1Z60_PCH_MonteCarlo(my_f, randPoints, ...
    "divideAndConquer") - integralAccurate);
my_time(6) = toc;

end % function