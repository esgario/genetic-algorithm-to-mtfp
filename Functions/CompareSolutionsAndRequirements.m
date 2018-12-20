% A - Solution
% R - Requirement Matrix
% D - Individual Department Vector

function f = CompareSolutionsAndRequirements(A,R,D)
[nj,nk] = size(R);

% construct requirement solution matrix
for j=1:nj
    index = find(D == j);
    for k=1:nk
        Ra(j,k) = sum(A(index,k));
    end
end

f = sum(sum(abs(R - Ra)));