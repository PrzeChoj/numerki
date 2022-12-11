rng(1);

% lamie regułe Do Not Repeat Yourself
% Ale moge, bo to tylko generowanie obrazka

my_f = @(x,y) 4*(((x-0.5).*(x-0.5) + (y-0.5).*(y-0.5)) < 0.25);
% Prawdziwa wartość całki to pi

% Plot circle
angles = linspace(0, 2*pi, 500);
radius = 0.5;
CenterX = 0.5;
CenterY = 0.5;
x = radius * cos(angles) + CenterX;
y = radius * sin(angles) + CenterY;

randpoints = 6000;
sz = 1;

[integral, points] = P1Z60_PCH_MonteCarlo(my_f, randpoints, "basic");
disp(integral - pi);
scatter(points(1,:), points(2,:), sz)
hold on;
plot(x, y, 'b-', 'LineWidth', 2);
title("basic")
subtitle("Jednostajnie wylosowane. Zdarzeją się grupki punktów")
input("");
hold off;

disp("Wait 2 seconds")
[integral, points] = P1Z60_PCH_MonteCarlo(my_f, randpoints, "quasiMC");
disp(integral - pi);
scatter(points(1,:), points(2,:), sz)
hold on;
plot(x, y, 'b-', 'LineWidth', 2);
title("quasi Monte Carlo")
subtitle("Ciąg Faure - bardzo regularny")
input("");
hold off;

[integral, points] = P1Z60_PCH_MonteCarlo(my_f, randpoints, "reimann");
disp(integral - pi);
scatter(points(1,:), points(2,:), sz)
hold on;
plot(x, y, 'b-', 'LineWidth', 2);
title("reimann")
subtitle("Równorozłożone")
input("");
hold off;

[integral, points] = P1Z60_PCH_MonteCarlo(my_f, randpoints, "imporftanceSampling", [1,2,1,5]);
disp(integral - pi);
scatter(points(1,:), points(2,:), sz)
hold on;
plot(x, y, 'b-', 'LineWidth', 2);
title("Imporftance Sampling")
subtitle("Losowane zgodnie z rozkładem beta(1,2) x beta(1,5)")
input("");
hold off;

[integral, points] = P1Z60_PCH_MonteCarlo(my_f, randpoints, "latinHypercube");
disp(integral - pi);
scatter(points(1,:), points(2,:), sz)
hold on;
plot(x, y, 'b-', 'LineWidth', 2);
title("Latin Hypercube")
subtitle("Jednostajnie wylosowane. Raczej nie zdarzeją się grupki punktów")
input("");
hold off;

[integral, points] = P1Z60_PCH_MonteCarlo(my_f, randpoints, "divideAndConquer", 50);
disp(integral - pi);
scatter(points(1,:), points(2,:), sz)
hold on;
plot(x, y, 'b-', 'LineWidth', 2);
title("Divide And Conquer")
subtitle("Więcej punktów losowanych tam, gdzie funkcja bardziej się zmienia")
input("");
hold off;