function [] = test1()
% Podstawowe testy całkowania dla pryzkładowej funkcji, której znana jest
% prawdziwa wartość całki

randPoints = 100;
rng(1);

my_f = @(x,y) y.*exp(x);
integralAccurate = (exp(1)-1)/2;
my_time1 = zeros(1,6);
err1 = zeros(3,6);

disp("Test sprawdza poprawność zaimplementowanych algorytmów " + ...
    "całkowania")
disp("metodami Monte Carlo na przykładowej funkcji f(x,y) = y*exp(x)")
disp("przecałkowanej na kwadracie [0,1]x[0,1].")
disp("Teoretyczna wartość tej całki wynosi (e - 1)/2, czyli około " ...
    + integralAccurate + ".")
disp(" ")
disp("Wykonane zostaną testy dla każdego typu dla " + ...
    "100 wylosowanych punktów,")
disp("oraz kolejne testy dla 1000 wylosowanych punktów.")
disp("Porównane będą błędy oraz czas obliczeń.")
disp("Niektóre metody nie są deterministyczne dlatego " + ...
    "porównane zostaną wyniki z 3 wywołań.")
disp("W ten sposób sprawdzona będzie niepewność wyniku.")
disp(" ")

disp("W celu reprodukowalności wniosków ustawiono ziarno losowości.")
disp(" ")

disp("Kolejność algorytmów jest następująca:")
disp(["basic", "quasiMC", "reimann", "imporftanceSampling", ...
    "latin Hypercube", "divide And Conquer"])

[err1(1,:), my_time_i] = test1GetError(my_f, randPoints, integralAccurate);
my_time1 = my_time1 + my_time_i;
[err1(2,:), my_time_i] = test1GetError(my_f, randPoints, integralAccurate);
my_time1 = my_time1 + my_time_i;
[err1(3,:), my_time_i] = test1GetError(my_f, randPoints, integralAccurate);
my_time1 = my_time1 + my_time_i;
my_time1 = my_time1 / 3;

input("");

disp("Dla 100 punktów:")
disp("Czas obliczeń (w milisekundach):")
disp(my_time1 * 1000);
disp("Otrzymane błędy (bezwzględne od prawdziwej wartości całki):")
disp(err1);

disp(" ")
disp("Zauważyć można, że zdecydowanie najdłużej trawły obliczenia " + ...
    "dla quasiMC.")
disp("Obserwacja ta nie dziwi, gdyż obliczenie to wymaga " + ...
    "wyznaczenia ciągu Faure, co jest zasobożerne.")
input("");
disp("Warto zwrócić uwagę na algorytmy deterministyczne " + ...
    "(quasiMC oraz reimann), gdyż")
disp("w każdym z trzech przebiegów dały one te same wyniki.")

my_time2 = zeros(1,6);
err2 = zeros(3,6);
[err2(1,:), my_time_i] = test1GetError(my_f, randPoints*10, ...
    integralAccurate);
my_time2 = my_time2 + my_time_i;
[err2(2,:), my_time_i] = test1GetError(my_f, randPoints*10, ...
    integralAccurate);
my_time2 = my_time2 + my_time_i;
[err2(3,:), my_time_i] = test1GetError(my_f, randPoints*10, ...
    integralAccurate);
my_time2 = my_time2 + my_time_i;
my_time2 = my_time2 / 3;

input("");

disp("Dla 1000 punktów:")
disp("Czas obliczeń (w milisekundach):")
disp(my_time2 * 1000);
disp("Otrzymane błędy (bezwzględne od prawdziwej wartości całki):")
disp(err2);

disp("Testy dla większej liczby punktów " + ...
    "potwierdzają wcześniejsze obserwacje.")
disp("Widzimy, że najgorzej poradziły sobie metody basic oraz " + ...
    "reimann, co nie dziwi, gdyż są to najprostrze metody MC.")
disp(" ")
disp("Warto wzrócić uwagę na czwartą kolumnę, która reprezentuje " + ...
    "Importance Sampling.")
disp("Widzimy, że jej wyniki są lepsze od " + ...
    "basic. Jest tak dlatego, że parapetry rozkładu beta zostały ")
disp("dobrane tak, aby 'pasowały' do funkcji podcałkowej " + ...
    "(geogebra.org/3d/fqytxuv7).")

end % function