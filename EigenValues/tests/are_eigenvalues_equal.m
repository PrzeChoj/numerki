function [are_equal] = are_eigenvalues_equal(A,B)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
[rowsA, ~] = size(A);
[rowsB, ~] = size(B);

if rowsA ~= rowsB
    are_equal = false;
    return
end

are_equal = zeros(rowsA, 1);
tolerance = 0.002;
for rowa = 1 : rowsA
  are_equal(rowa) = any(abs(B - A(rowa)) < tolerance);
end

are_equal = all(are_equal);

end % function