rng(1);

my_f = @(x,y) x.*x.*x.*y + 4*x.*y.*y - 19/24;
% prawdziwa calka to 0

ns = floor(exp(3:0.1:15));
i_s = zeros(length(ns), 1);
errors = zeros(length(ns), 1);

for i = 1:length(ns)
    [i_s(i), ~] = P1Z60_PCH_MonteCarlo(my_f, ns(i), "basic");
    errors(i) = abs(i_s(i));
end

loglog(ns, errors)
hold on;
plot(ns, 1./sqrt(ns))
legend("Błąd estymacji", "1/sqrt(n)")
xlabel("n")
title("Zbieżnośc błędu estymacji wraz ze zwiększaniem bużdetu")
hold off;