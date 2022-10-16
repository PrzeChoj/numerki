% Przemyslaw Chojecki
function x = itlinsolc(ciA, vicA, b)
    max_it = 500;
    tol = 10^-9;
    
    % Wzór z:
    % https://en.wikipedia.org/wiki/Gauss–Seidel_method#Program_to_solve_arbitrary_no._of_equations_using_Matlab

    d = size(ciA,2); % 2 <= d <= 50
    n = size(ciA,1); % 2 <= n <= 5000000
    % Zakładam, że ciA ma taki sam rozmiar jak vicA
      % oraz, że length(b) == n
    x = zeros(n,1);
    r = b; % r = b - Ax
    if norm(r, 1) < tol
        return
    end

    for i = 1:max_it
        for j = 1:n
            new_x_j = b(j);
            for k = 1:d
                if ciA(j,k) == j
                    Ajj = vicA(j,k);
                else
                    new_x_j = new_x_j - vicA(j,k) * x(ciA(j,k)); % gdy k < j, to bierzemy x z nowej iteracji; gdy k > j, to bierzemy x ze starej iteracji
                end
            end
            new_x_j = new_x_j / Ajj;
            x(j) = new_x_j;
        end

        % r = b - Ax:
        r = b;
        for j = 1:n
            for k = 1:d
                r(j) = r(j) - vicA(j,k) * x(ciA(j,k));
            end
        end
        %disp(norm(r, 1)); % debugging mode
        if norm(r, 1) < tol % x jest już wystarczająco dobry
            return
        end
    end

    % nie udało się zbiec :(

    x = zeros(n,1);
end