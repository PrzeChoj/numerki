function [] = test2()
% Projekt 1, zadanie 60
% Adam Przemyslaw Chojecki, 298814
%
% Pokazuje, ze podstawowy MC jest rzedu o(sqrt(n))

rng(1);

disp("Test sprawdza, ze metoda podstawowa jest rzedu o(sqrt(n)), " + ...
    "gdzie n to budzet estymacji.")
disp(" ")
disp("Test wyestymuje wartosc calki z funkcji " + ...
    "f(x,y) = x^2y + 7xy^3 + e^x dla roznych budzetow.")
disp("Pokazane zostanie, ze prosta o najlepiej " + ...
    "przyblizajaca funkcje log bledu od log budzetu")
disp("ma wspolczynnik kierunkowy bliski a = -0.5.")

my_f = @(x,y) x.*x.*y + 7*x.*y.*y.*y + exp(x) - (24*exp(1)+1)/24;
% prawdziwa calka to 0

org_ns = 3:1:15;
ns = floor(exp(org_ns));
i_s = zeros(length(ns), 1);
errors = zeros(1, length(ns));

for i = 1:length(ns)
    i_s(i) = P1Z60_PCH_MonteCarlo(my_f, ns(i), "basic");
    errors(i) = abs(i_s(i));
end

result = [org_ns; log(errors)];

my_fit = polyfit(org_ns, log(errors), 1);
mdl = fitlm(org_ns, log(errors));

input("");

disp("Uzyskane wyniki (pierwszy wiersz to log budzetu, " + ...
    "a drugi to log blad bezwzgledny):");
disp(result);
input("")
disp("Widzimy, ze mniej wiecej wartosci maleja z kazdym powiekszeniem n.")
disp(" ")
disp("Znajdzmy prosta najlepszego dopasowania estymatorem BLUE:")
disp(strcat('y = ', num2str(my_fit(1)), '*x + (', num2str(my_fit(2)), ')'));
disp(" ")
disp("Widzimy wiec, ze wspolczynnik stajacy przy " + ...
    "'x' jest bliski -0.5.")
disp(" ")
disp("Sprawdzmy, czy prosa jest dobrze dopasowana. Zrobimy to miara R^2:")
disp(strcat("R^2 = ", num2str(mdl.Rsquared.Ordinary)))
disp("Widzimy wiec, ze jest ona bliska 1, co mozna interpretowac " + ...
    "jako dobre dopasowanie prostej do danych.")

end % function