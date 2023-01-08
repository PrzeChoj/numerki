rng(1);

% Ile wartosci wlasnych w zaleznosci od liczby iteracji

n = 50;
M = 100;
max_iter = 100000000;

found_k_all = zeros(M, n);

for j=1:M
    disp(j)
    U = rand(n);
    [Q, ~] = qr(U);
    eigs_true = rand(1, n)*2-1; % U(-1,1)
    A = Q*diag(eigs_true)*(Q.');
    A = hess(A);
    
    [w_wlasne, found_k] = P2Z55_PCH_HessenQR(A, max_iter);
    if size(w_wlasne, 2) < n
        error("Nie udalo sie zbiedz w danej ilosci iteracji")
    end
    
    found_k_all(j, :) = flipud(found_k);
end

h = histogram(reshape(found_k_all,1,[]));
set(gca,'yscale','log')
ylim([0.1, 10000])
xlabel("Liczba iteracji",'FontSize',20,'FontWeight','bold')
ylabel("Ilość wystąpień danej liczby iteracji",'FontSize',20,'FontWeight','bold')
title("Histogram liczby iteracji potrzbenej do znalezienia wartości własnej",'FontSize',30,'FontWeight','bold')
