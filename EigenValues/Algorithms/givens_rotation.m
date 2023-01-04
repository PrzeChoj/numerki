function [new_a, new_b, c, s] = givens_rotation(a, b)
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
% 
% Na podstawie algorytmu 9
% https://addi.ehu.es/bitstream/handle/10810/26427/TFG_Erana_Robles_Gorka.pdf?sequence=1

if b == 0
    c = 1.0;
    s = 0;
    new_a = a;
    new_b = 0;
elseif a == 0
    c = 0;
    s = 1;
    new_a = b;
    new_b = 0;
else
    mu = a/abs(a);
    tau = abs(a)+abs(b);
    nu = tau*sqrt(abs(a/tau)^2+abs(b/tau)^2);
    c = abs(a)/nu;
    s = mu*conj(b)/nu;
    new_a = nu*mu;
    new_b = 0;
end

end