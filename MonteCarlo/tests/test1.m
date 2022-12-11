function [] = test1()
% Projekt 1, zadanie 60
% Adam Przemyslaw Chojecki, 298814
%
% Podstawowe testy calkowania dla pryzkladowej funkcji, ktorej znana jest
% prawdziwa wartosc calki

randPoints = 100;
rng(1);

my_f = @(x,y) y.*exp(x);
integralAccurate = (exp(1)-1)/2;
my_time1 = zeros(1,6);
err1 = zeros(3,6);

disp("Test sprawdza poprawnosc zaimplementowanych algorytmow " + ...
    "calkowania")
disp("metodami Monte Carlo na przykladowej funkcji f(x,y) = y*exp(x)")
disp("przecalkowanej na kwadracie [0,1]x[0,1].")
disp("Teoretyczna wartosc tej calki wynosi (e - 1)/2, czyli okolo " ...
    + integralAccurate + ".")
disp(" ")
disp("Wykonane zostana testy dla kazdego typu dla " + ...
    "100 wylosowanych punktow,")
disp("oraz kolejne testy dla 1000 wylosowanych punktow.")
disp("Porownane beda bledy oraz czas obliczen.")
disp("Niektore metody nie sa deterministyczne dlatego " + ...
    "porownane zostana wyniki z 3 wywolan.")
disp("W ten sposob sprawdzona bedzie niepewnosc wyniku.")
disp(" ")

disp("W celu reprodukowalnosci wnioskow ustawiono ziarno losowosci.")
disp(" ")

disp("Kolejnosc algorytmow jest nastepujaca:")
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

disp("Dla 100 punktow:")
disp("Czas obliczen (w milisekundach):")
disp(my_time1 * 1000);
disp("Otrzymane bledy (bezwzgledne od prawdziwej wartosci calki):")
disp(err1);

disp(" ")
disp("Zauwazyc mozna, ze zdecydowanie najdluzej trawly obliczenia " + ...
    "dla quasiMC.")
disp("Obserwacja ta nie dziwi, gdyz obliczenie to wymaga " + ...
    "wyznaczenia ciagu Faure, co jest zasobozerne.")
input("");
disp("Warto zwrocic uwage na algorytmy deterministyczne " + ...
    "(quasiMC oraz reimann), gdyz")
disp("w kazdym z trzech przebiegow daly one te same wyniki.")

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

disp("Dla 1000 punktow:")
disp("Czas obliczen (w milisekundach):")
disp(my_time2 * 1000);
disp("Otrzymane bledy (bezwzgledne od prawdziwej wartosci calki):")
disp(err2);

disp("Testy dla wiekszej liczby punktow " + ...
    "potwierdzaja wczesniejsze obserwacje.")
disp("Widzimy, ze najgorzej poradzily sobie metody basic oraz " + ...
    "reimann, co nie dziwi, gdyz sa to najprostrze metody MC.")
disp(" ")
disp("Warto wzrocic uwage na czwarta kolumne, ktora reprezentuje " + ...
    "Importance Sampling.")
disp("Widzimy, ze jej wyniki sa lepsze od " + ...
    "basic. Jest tak dlatego, ze parapetry rozkladu beta zostaly ")
disp("dobrane tak, aby 'pasowaly' do funkcji podcalkowej " + ...
    "(geogebra.org/3d/fqytxuv7).")

end % function