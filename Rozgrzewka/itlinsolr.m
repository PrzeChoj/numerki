% Przemyslaw Chojecki
function x = itlinsolr(riA, virA, b)
    max_it = 500;
    tol = 10^-9;
    
    % Wzór z:
    % https://en.wikipedia.org/wiki/Gauss–Seidel_method#Program_to_solve_arbitrary_no._of_equations_using_Matlab

    d = size(riA,1); % 2 <= d <= 50
    n = size(riA,2); % 2 <= n <= 5000000
    % Zakładam, że riA ma taki sam rozmiar jak virA
      % oraz, że length(b) == n
    x = zeros(n,1);
    r = b; % r = b - Ax = b
    if norm(r, 1) < tol
        return
    end

    for i = 1:max_it
        new_x = b;
        A_przekontna = zeros(n,1);
        for j = 1:n
            for k = 1:d
                if riA(k,j) == j
                    A_przekontna(j) = virA(k,j);
                else
                    new_x(riA(k,j)) = new_x(riA(k,j)) - virA(k,j) * x(j);
                    % w całej pentli używamy starych wartości x,
                    % czyli zbieżność będzie wolniejsza niż w zadaniu C.
                end
            end
        end
        x = new_x./A_przekontna; % dzielenie element po elemencie
        
        % r = b - Ax:
        r = b;
        for j = 1:n
            for k = 1:d
                r(riA(k,j)) = r(riA(k,j)) - virA(k,j) * x(j);
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