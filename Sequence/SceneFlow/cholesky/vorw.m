function y = vorw(L,b,n)
%Die Funktion vorw.m löst das LGS Ly=b, L linke untere Dreieckmatrix, durch
%Vorwärtseinsetzen

y = zeros(n,1);
y(1) = b(1) / L(1,1);
for i=2:n
    summe = 0;
    for j=1:i-1
        summe = summe + L(i,j)*y(j);
    end
    y(i) = (b(i) - summe) / L(i,j);
end
