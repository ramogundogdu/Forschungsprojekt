function [ VertsOut ] = replaceVerticies( Verts1, Verts2 )
% replaces Verticies in Verts1 with those in Verts2, according to their
% indicies and validity

% Verts1, Verts2: 3xN matrices with N Verticies.
% VertsOut: Verts1 replaced with Verts2 at indicies that are valide (not
% NaN) in Verts2

if(size(Verts1,1) ~= 3 || size(Verts2,1) ~= 3)
    error('Verticies must be column vectors [X;Y;Z]');
end

if(size(Verts1,2) ~= size(Verts2,2))
    error('Matrix dimension must match (number of verticies)');
end

% check for invalid entries in Verts1 - must not happen!
V1IsValid = all(~any(isnan(Verts1)));
if(~V1IsValid)
    error('Verts1 must only contain valid entries');
end

V2ValidIndx = any( ~isnan(Verts2) );

VertsOut = Verts1;

VertsOut(:, V2ValidIndx) = Verts2(:, V2ValidIndx);
end

