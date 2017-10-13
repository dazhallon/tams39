function [A] = symmatrix(array)
% Creates a symmetric matrix out of an array. 

n = get_tri_num(length(array));
I = zeros(n*(n-1)/2,1);
J = I;
k = 1;
for i = 1:n
  for j = i:n
    I(k) = i;
    J(k) = j;
    k = k+1;
  end
end

A = sparse(I, J, array, n, n);

A = A + A' - eye(n).*diag(A);

A = full(A);
end

function [n] = get_tri_num(N)
% Finds what integer, n, corresponds to the triangular number N
n = -0.5 + sqrt(2*N + 0.25); % reversed formula for triangular number
if ~(floor(n) == n)
  error('The array containing the matrix elements has a lenfgth that is not a trainglual number')
end
end