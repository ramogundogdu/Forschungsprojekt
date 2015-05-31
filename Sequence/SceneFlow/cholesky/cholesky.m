%Implementation des Cholesky-Algoritmus
%Gleihungssystem A x = b;
%A Matrix
%b Rechte Seite
%x L�sungsvektor

disp('Implementation des Cholesky-Algoritmus f�r')
disp('positiv definite Matrizen A f�r das LGS A x = b.')
disp('')
disp('')
disp('Bitte quatratische, symmetrische, ')
A = input('positiv definite Matrix A eingeben. A = ');
disp('')
disp('')
b = input('Bitte L�sungsvektor b eingeben b = ');
disp('')
disp('')

% Dimension von A;
[n,m] = size(A);
if n~=m
    error('Matrix A ist nicht quadratisch!');
end

% ist die Matrix A symetrisch?

if A == A'
else
    error('Matrix A ist nicht symmetrisch');
end

if min(eig(A) < 1.e-15)
    error('Matrix A ist nicht positiv definit!');
end

% Ist b ein Spaltenvektor?

[q,p] = size(b);
if q~=n
    error('b hat die falsche Dimension!');
end

%Cholesky-Zerlegung A = L L'
%L ist untere Dreiecksmatrix

L = zeros(n,n);
for j=1:n
    summe1 = 0;
    for k=1:j-1
        summe1 = summe1 + (L(j,k))^2;
    end
    L(j,j) = sqrt(A(j,j) - summe1);
    for i=j+1:n
        summe2 = 0;
        for k=1:j-1
            summe2 = summe2 + L(i,k) * conj(L(j,k));
        end
        L(i,j) = (A(i,j) - summe2) / L(j,j);
    end
end

%Ausgabe der gewonnenen Matrix L
disp ('Die untere Dreiecksmatrix L:');
disp(L);

%L�sen des Gleichungssystems
%Schritt 1: Vorw�rsteinsetzen, l�se Ly=b;
y = vorw(L,b,n);

%Schritt 2: R�ckw�rtssubstitution Rx=y mit R=L'
x = rueckw(L',y,n);

disp('L�sungsvektor x=');
disp(x);


    