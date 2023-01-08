function [x, y] = apply_givens_rotation(c, s, x, y)
% Projekt 2, zadanie 55
% Adam Przemyslaw Chojecki, 298814
% 
% Rotacja policzona za pomoca funckji givens_rotation()
%   bedzie zaaplikowana do pozostalych wartosci macierzy

t = c*x+s*y;
y = c*y-conj(s)*x;
x = t;

end % function