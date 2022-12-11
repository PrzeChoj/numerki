function [integral, points] = divideAndConquer_integrate_recurrent(f, ...
    randPoints, n_var_est, a, b, c, d, oldEstimate)
% Projekt 1, zadanie 60
% Adam Przemyslaw Chojecki, 298814
% 
% Oblicza wartosc calki zgodnie z opisem w funkcji P1Z60_PCH_MonteCarlo.
% Rownierz i tam opisane sa dane wyjsciowe i czesc wejsciowych.
%
% oldEstimate to parametr przekazywany w rekurencji mowiacy o
% wczesniej policzonym estymatorze calki na danym kwadracie
% 
% Przecalkuj na kwadracie [a, b] x [c, d] wywolujac rekurencyjnie siebie.
% 
% Algorytm na podstawie artykulu
% https://web.maths.unsw.edu.au/~zdravkobotev/variancereductionCorrection.pdf

my_eps = 0.01; % Ustabilizowanie szczegolenie dla przypadku, gdy var() = 0

if randPoints == 0
    % No more running
    integral = oldEstimate;
    points = zeros(2,0);
elseif randPoints < 4 * n_var_est + 10
    % Bez rekurencji, po prostu policz pozostale punkty
    xs = rand(2,randPoints);
    xs(1,:) = xs(1,:) * (b-a) + a;
    xs(2,:) = xs(2,:) * (d-c) + c;

    fs = f(xs(1,:), xs(2,:));
    points = xs;

    integral = sum(fs) / randPoints * (b-a) * (d-c);
    if exist('oldEstimate','var')
        % Uzyj starej wartosci estymacji
        integral = (integral * randPoints + oldEstimate * n_var_est) / ...
            (randPoints + n_var_est);
    end
else
    xs = rand(2,4*n_var_est);
    points = zeros(2, randPoints);

    % 1 to lewa dolna cwiartka kwadratu [a,b]x[c,d]
    xs1(1,:) = xs(1,1:n_var_est) * (b-a)/2 + a;
    xs1(2,:) = xs(2,1:n_var_est) * (d-c)/2 + c;
    points(:, 1:n_var_est) = xs1;
    fs1 = f(xs1(1,:), xs1(2,:));
    oldEstimate1 = sum(fs1) / n_var_est * (b-a)/2 * (d-c)/2;
    s1 = std(fs1) + my_eps;

    % 2 to prawa dolna cwiartka kwadratu [a,b]x[c,d]
    xs2(1,:) = xs(1,(n_var_est+1):(2*n_var_est)) * (b-a)/2 + a + (b-a)/2;
    xs2(2,:) = xs(2,(n_var_est+1):(2*n_var_est)) * (d-c)/2 + c;
    points(:, (n_var_est+1):(2*n_var_est)) = xs2;
    fs2 = f(xs2(1,:), xs2(2,:));
    oldEstimate2 = sum(fs2) / n_var_est * (b-a)/2 * (d-c)/2;
    s2 = std(fs2) + my_eps;

    % 3 to lewa gorna cwiartka kwadratu [a,b]x[c,d]
    xs3(1,:) = xs(1,(2*n_var_est+1):(3*n_var_est)) * (b-a)/2 + a;
    xs3(2,:) = xs(2,(2*n_var_est+1):(3*n_var_est)) * (d-c)/2 + c + (d-c)/2;
    points(:, (2*n_var_est+1):(3*n_var_est)) = xs3;
    fs3 = f(xs3(1,:), xs3(2,:));
    oldEstimate3 = sum(fs3) / n_var_est * (b-a)/2 * (d-c)/2;
    s3 = std(fs3) + my_eps;

    % 4 to prawa gorna cwiartka kwadratu [a,b]x[c,d]
    xs4(1,:) = xs(1,(3*n_var_est+1):(4*n_var_est)) * (b-a)/2 + a + (b-a)/2;
    xs4(2,:) = xs(2,(3*n_var_est+1):(4*n_var_est)) * (d-c)/2 + c + (d-c)/2;
    points(:, (3*n_var_est+1):(4*n_var_est)) = xs4;
    fs4 = f(xs4(1,:), xs4(2,:));
    oldEstimate4 = sum(fs4) / n_var_est * (b-a)/2 * (d-c)/2;
    s4 = std(fs4) + my_eps;

    randPointsLeft = randPoints - 4*n_var_est;

    sSum = s1+s2+s3+s4;

    randPoints1 = floor(randPointsLeft * s1/sSum);
    randPoints2 = floor(randPointsLeft * s2/sSum);
    randPoints3 = floor(randPointsLeft * s3/sSum);
    randPoints4 = floor(randPointsLeft * s4/sSum);
    % Byc moze gubie, ale co najwyzej 4 punkty
    cumrandPoints = cumsum([randPoints1, randPoints2, ...
        randPoints3, randPoints4]);

    [i1, points1] = divideAndConquer_integrate_recurrent(f, ...
        randPoints1, n_var_est, a, b-(b-a)/2, c, d-(d-c)/2, oldEstimate1);
    [i2, points2] = divideAndConquer_integrate_recurrent(f, ...
        randPoints2, n_var_est, a+(b-a)/2, b, c, d-(d-c)/2, oldEstimate2);
    [i3, points3] = divideAndConquer_integrate_recurrent(f, ...
        randPoints3, n_var_est, a, b-(b-a)/2, c+(d-c)/2, d, oldEstimate3);
    [i4, points4] = divideAndConquer_integrate_recurrent(f, ...
        randPoints4, n_var_est, a+(b-a)/2, b, c+(d-c)/2, d, oldEstimate4);

    points(:, (4*n_var_est + 1):(4*n_var_est + cumrandPoints(1))) = points1;
    points(:, (4*n_var_est + cumrandPoints(1) + 1):(4*n_var_est + ...
        cumrandPoints(2))) = points2;
    points(:, (4*n_var_est + cumrandPoints(2) + 1):(4*n_var_est + ...
        cumrandPoints(3))) = points3;
    points(:, (4*n_var_est + cumrandPoints(3) + 1):(4*n_var_est + ...
        cumrandPoints(4))) = points4;

    integral1 = ( i1 * randPoints1 + oldEstimate1 * n_var_est ) / ...
        (randPoints1 + n_var_est);
    integral2 = ( i2 * randPoints2 + oldEstimate2 * n_var_est ) / ...
        (randPoints2 + n_var_est);
    integral3 = ( i3 * randPoints3 + oldEstimate3 * n_var_est ) / ...
        (randPoints3 + n_var_est);
    integral4 = ( i4 * randPoints4 + oldEstimate4 * n_var_est ) / ...
        (randPoints4 + n_var_est);

    integral = integral1+integral2+integral3+integral4;
end