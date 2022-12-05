function [integral] = divideAndConquer_integrate_recurrent(f, randPoints, n_var_est, a, b, c, d, oldEstimate)
% Przecałkuj wywołując rekurencyjnie siebie.
% Całkuj na kwadracie [a, b] x [c, d]

% Based on https://web.maths.unsw.edu.au/~zdravkobotev/variancereductionCorrection.pdf

if randPoints == 0
    % No more running
    integral = oldEstimate;
elseif randPoints < 4 * n_var_est + 10
    % Just draw the remaining ones - no recurrention
    xs = rand(2,randPoints);
    xs(1,:) = xs(1,:) * (b-a) + a;
    xs(2,:) = xs(2,:) * (d-c) + c;
    
    fs = f(xs(1,:), xs(2,:));
    
    integral = sum(fs) / randPoints * (b-a) * (d-c);
    if exist('oldEstimate','var')
        % Consider the already drawn ones
        integral = ( integral * randPoints + oldEstimate * n_var_est ) / (randPoints + n_var_est);
    end
else
    xs = rand(2,4*n_var_est);

    % 1 to lewy dolny
    xs1(1,:) = xs(1,1:n_var_est) * (b-a)/2 + a;
    xs1(2,:) = xs(2,1:n_var_est) * (d-c)/2 + c;
    fs1 = f(xs1(1,:), xs1(2,:));
    oldEstimate1 = sum(fs1) / n_var_est * (b-a)/2 * (d-c)/2;
    s1 = std(fs1);

    % 2 to prawy dolny
    xs2(1,:) = xs(1,(n_var_est+1):(2*n_var_est)) * (b-a)/2 + a + (b-a)/2;
    xs2(2,:) = xs(2,(n_var_est+1):(2*n_var_est)) * (d-c)/2 + c;
    fs2 = f(xs2(1,:), xs2(2,:));
    oldEstimate2 = sum(fs2) / n_var_est * (b-a)/2 * (d-c)/2;
    s2 = std(fs2);

    % 3 to lewy górny
    xs3(1,:) = xs(1,(2*n_var_est+1):(3*n_var_est)) * (b-a)/2 + a;
    xs3(2,:) = xs(2,(2*n_var_est+1):(3*n_var_est)) * (d-c)/2 + c + (d-c)/2;
    fs3 = f(xs3(1,:), xs3(2,:));
    oldEstimate3 = sum(fs3) / n_var_est * (b-a)/2 * (d-c)/2;
    s3 = std(fs3);

    % 4 to prawy górny
    xs4(1,:) = xs(1,(3*n_var_est+1):(4*n_var_est)) * (b-a)/2 + a + (b-a)/2;
    xs4(2,:) = xs(2,(3*n_var_est+1):(4*n_var_est)) * (d-c)/2 + c + (d-c)/2;
    fs4 = f(xs4(1,:), xs4(2,:));
    oldEstimate4 = sum(fs4) / n_var_est * (b-a)/2 * (d-c)/2;
    s4 = std(fs4);

    randPointsLeft = randPoints - 4*n_var_est;

    sSum = s1+s2+s3+s4;

    randPoints1 = floor(randPointsLeft * s1/sSum);
    randPoints2 = floor(randPointsLeft * s2/sSum);
    randPoints3 = floor(randPointsLeft * s3/sSum);
    randPoints4 = floor(randPointsLeft * s4/sSum);
    % Być może gubię, ale co najwyżej 4

    i1 = divideAndConquer_integrate_recurrent(f, randPoints1, n_var_est, a, b-(b-a)/2, c, d-(d-c)/2, oldEstimate1);
    i2 = divideAndConquer_integrate_recurrent(f, randPoints2, n_var_est, a+(b-a)/2, b, c, d-(d-c)/2, oldEstimate2);
    i3 = divideAndConquer_integrate_recurrent(f, randPoints3, n_var_est, a, b-(b-a)/2, c+(d-c)/2, d, oldEstimate3);
    i4 = divideAndConquer_integrate_recurrent(f, randPoints4, n_var_est, a+(b-a)/2, b, c+(d-c)/2, d, oldEstimate4);

    integral1 = ( i1 * randPoints1 + oldEstimate1 * n_var_est ) / (randPoints1 + n_var_est);
    integral2 = ( i2 * randPoints2 + oldEstimate2 * n_var_est ) / (randPoints2 + n_var_est);
    integral3 = ( i3 * randPoints3 + oldEstimate3 * n_var_est ) / (randPoints3 + n_var_est);
    integral4 = ( i4 * randPoints4 + oldEstimate4 * n_var_est ) / (randPoints4 + n_var_est);

    integral = integral1+integral2+integral3+integral4;
end