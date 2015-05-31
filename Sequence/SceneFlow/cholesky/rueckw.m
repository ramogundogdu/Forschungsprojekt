function x = rueckw(R,y,n)
%Die Funktion rueckw.m löst das LGS L'x=y, L'=R rechte obere Dreieckmatrix,
%durch Rückwärtseinsetzen

x = zeros(n,1);
x(n) = y(n) / R(n,n);
for i=n-1:-1:1
    summe = 0;
    for j=i+1:n
        summe = summe + R(i,j)*x(j);
    end
    x(i)=(y(i) - summe) / R(i,i);
end

