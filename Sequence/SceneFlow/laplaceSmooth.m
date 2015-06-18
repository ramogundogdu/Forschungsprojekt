function [ VerstT1 ] = laplaceSmooth( VertsBase, VertsT0, LTL, SFV, alpha )
%LAPLACESMOOTH Summary of this function goes here
%   Detailed explanation goes here

% IN
% VertsBase, VertsT0: 3xN Vertex positions - template Mesh and current Mesh
% LTL: weight matrix * its transposed form
% SFV: scene flow vectors from VertsT0 to VertsT1
% alpha: scale factor for LTL - between 0..1

if( size(VertsBase,2) ~= size(VertsT0, 2) )
    error('Input matrices must have the same dimensions (number of verticies)');
end

if( size(LTL,1) ~= size(LTL,2))
    error('LTL must be symetric');
end

disp(' --- start: laplaceSmooth ---');
numVerts = size(VertsBase,2);
I = eye(numVerts);
VerstT1 = zeros(3, numVerts);

F1 = I + alpha*LTL;

% x coords
disp(' --- x coords ---');
F2x = VertsT0(1,:)' + SFV(1,:)' + alpha * LTL * VertsBase(1,:)';
xOut = F1\F2x;

% y coords
disp(' --- y coords ---');
F2y = VertsT0(2,:)' + SFV(2,:)' + alpha * LTL * VertsBase(2,:)';
yOut = F1\F2y;

% z coords
disp(' --- z coords ---');
F2z = VertsT0(3,:)' + SFV(3,:)' + alpha * LTL * VertsBase(3,:)';
zOut = F1\F2z;


VerstT1 = [ xOut'; yOut'; zOut' ];

disp(' --- done: laplaceSmooth ---');

end

