function x = C(ciA, vicA, b)
    max_it = 10;
    tol = 10^-9;
    
    % https://en.wikipedia.org/wiki/Conjugate_gradient_method

    d = size(ciA,2); % 2 <= d <= 50
    n = size(ciA,1); % 2 <= n <= 5000000
    % Zakładam, że ciA ma taki sam rozmiar jak vicA
      % oraz, że length(b) == n
    x = zeros(n,1);
    r = b; % r = b - Ax
    if norm(r, 1) < tol
        return
    end

    p = r;

    for i = 1:max_it % Jeśli n < max_it, to zbiegnę na pewno (wynika z teorii)
        Ap = zeros(n,1);
        for j = 1:n
            for k = 1:d
                Ap(j) = Ap(j) + vicA(j,k)*p(ciA(j,k));
            end
        end

        pAp = p'*Ap; % to jest liczba \in \mathbb{R}
        rr = r'*r; % bede tego używał 2 razy, wiec zapiszę wynik
        alpha = rr / pAp;

        x = x + alpha * p; % Aktualizacja
        r = r - alpha * Ap;
        disp(norm(r, 1));
        if norm(r, 1) < tol % x jest już wystarczająco dobry
            return
        end

        beta = r'*r / rr; % rr jest policzone na błędzie z poprzedniej iteracji
        p = r + beta*p;
    end

    % nie udało się zbiec :(

    x = zeros(n,1);
end