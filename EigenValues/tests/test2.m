function [] = test2()
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
%
% Sprawdza dzialanie algorytmu gdy jest wiecej niz 2 wartosci wlasne
% bliskie co do modulu

disp("Test sprawdza dzialanie algorytmu w sytuacji, gdy wiecej niz 2")
disp("wartosci wlasne sa bliskie co do modulu.")
disp("========================================================")

rng(1)

n = 50;
U = rand(n);
[Q, ~] = qr(U);
eigs_true = [rand(1, n-4)*2-1,1,1,1,1];
A = Q*diag(eigs_true)*(Q.');
H = hess(A);

my_eig = P2Z55_PCH_HessenQR(H, 5000).';
input("")
disp("Uzyto algorytmu do znalezienia wartosci wlasnych macierzy 50x50,")
disp("ktora miala 4 (cztery) wartosci wlasne rowne 1, a pozostale")
disp("46 wartosci wlasnych zostalo wylosowane z rozkladu U(-1,1).")
disp(" ")
if are_eigenvalues_equal(eigs_true.', my_eig)
    disp("Wszystkie wartosci wlasne zostaly poprawnie znalezione.")
else
    disp("Ktoras z wartosci wlasnych nie znostala znaleziona.")
end

disp("========================================================")
input("")

n = 50;
U = rand(n);
[Q, ~] = qr(U);
eigs_true = [rand(1, n-10)*2-1,1,1,1,1,1,1,1,1,1,1];
A = Q*diag(eigs_true)*(Q.');
H = hess(A);

disp("Uzyto algorytmu do znalezienia wartosci wlasnych macierzy 50x50,")
disp("ktora miala 10 (dziesiec) wartosci wlasne rowne 1, a pozostale")
disp("40 wartosci wlasnych zostalo wylosowane z rozkladu U(-1,1).")
my_eig = P2Z55_PCH_HessenQR(H, 5000).';
disp(" ")
if are_eigenvalues_equal(eigs_true.', my_eig)
    disp("Wszystkie wartosci wlasne zostaly poprawnie znalezione.")
else
    disp("Ktoras z wartosci wlasnych nie znostala znaleziona.")
end

disp("========================================================")
input("")

n = 6;
U = rand(n);
[Q, ~] = qr(U);
eigs_true = [rand(1, n-3),1,1i,-1i];
A = Q*diag(eigs_true)*(Q.');
H = hess(A);

my_eig = P2Z55_PCH_HessenQR(H, 5000).';
disp("Uzyto algorytmu do znalezienia wartosci wlasnych macierzy 6x6,")
disp("ktora miala 3 wartosci wlasne rowne [1, 1i, -1i], a pozostale")
disp("3 wartosci wlasnych byly rzeczywiste wylosowane z rozkladu U(-1,1).")
my_string = "Znalezione wartosci wlasne to [";
for i=1:size(my_eig, 1)-1
    my_string = my_string + my_eig(i) + ", ";
end
my_string = my_string + my_eig(size(my_eig, 1)) + "]";
disp(" ")
disp(my_string)

if size(my_eig, 1) == 3 && are_eigenvalues_equal(eigs_true(1:3).', my_eig)
    disp("Znalezniono tylko te wartości, które byly wylosowane")
    disp("Czyli nie znaleziono zadnej z modulem bliskim 1.")
elseif are_eigenvalues_equal(eigs_true.', my_eig)
    disp("Wszystkie wartosci wlasne zostaly poprawnie znalezione.")
else
    disp("Ktoras z wartosci wlasnych nie znostala znaleziona.")
end

end % function