function [new_a, new_b, c, s] = givens_rotation(a, b)
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
% 
% Implementacja ze strony
% https://en.wikipedia.org/wiki/Givens_rotation#Stable_calculation

if b == 0
    c = sign(a);
    if (c == 0)
        c = 1.0; % funkcja sign zwraca 0 dla 0.
    end
    s = 0;
    new_a = abs(a);
    new_b = 0;
elseif a == 0
    c = 0;
    s = sign(b);
    new_a = abs(b);
    new_b = 0;
elseif abs(a) > abs(b)
    t = b/a;
    u = sign(a) * sqrt(1+t*t);
    c = 1/u;
    s = c*t;
    new_a = a*u;
    new_b = 0;
else
    t = a/b;
    u = sign(b)*sqrt(1+t*t);
    s = 1/u;
    c = s*t;
    new_a = b*u;
    new_b = 0;
end
end