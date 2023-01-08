rng(1);

% Czy druga poddiagonala maleje najszybciej?

M = 1000;
n = 50;
max_iter = 1000;
eps_1 = 1e-10;
eps_2 = 1e-10;

val_last_elem = zeros(M, 1);
was_last_elem_smallest = false(M, 1);

for j=1:M
    disp("Obliczono " + j/M*100 + " %");

    k = 1;
    
    U = rand(n);
    [Q, ~] = qr(U);
    eigs_true = rand(1, n)*2-1; % U(-1,1)
    A = Q*diag(eigs_true)*(Q.');
    A = hess(A);
    
    A_k = A;
    norm_A = norm(A_k);
    
    while k <= max_iter
        [c, s, R] = qr_Givens(A_k);
        A_k = iloczyn(R, c, s);
        k = k+1;
    
        if any(abs(diag(A_k, -1)) < eps_1)
            val_last_elem(j) = abs(A_k(n, n-1));
            if val_last_elem(j) < eps_1
                was_last_elem_smallest(j) = true;
            end
            k = max_iter+1;
        end
    end
end

mean(was_last_elem_smallest)

histogram(log10(val_last_elem(~ was_last_elem_smallest)), 100)
line([-10,-10],[0,12], 'Color','red', 'LineWidth',5)
xlabel("log10 z modułu ostatniej wartości z poddiagonali",'FontSize', ...
    20,'FontWeight','bold')
ylabel("Ilość wystąpień danej wartości",'FontSize',20,'FontWeight','bold')
title("Histogram ostatniej wartości z poddiagonali, jeśli nie była" + ...
    " najmniejsza",'FontSize',30,'FontWeight','bold')
