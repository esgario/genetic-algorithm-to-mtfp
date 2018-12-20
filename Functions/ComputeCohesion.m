function [ Ea ] = ComputeCohesion( A, S, R, ni, nk )

nik = sum(R);
W = nik./ni;
for k=1:nk
    E(k,1) = groupEfficiency(A,S,k,ni,nik);
end
Ea = W*E;

function E = groupEfficiency(A,S,k,ni,nik)

E = 0;
for i=1:ni
    for j=1:ni
        E = E + A(i,k)*A(j,k)*S(i,j);
    end
end
E = E/nik(k);