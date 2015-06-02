function [ VertsOut_xyz ] = laplaceDeform( ConnectivityList, VertsT0_xyz, VertsFixedT1_xyz )
%LAPLACEDEFORM Summary of this function goes here
%   Detailed explanation goes here



numVerts = size(VertsT0_xyz, 2);
numVertsFixed = size(VertsFixedT1_xyz, 2);
LM = zeros(numVerts, numVerts);

% for each vertex  build adjacency row
for vI=1:numVerts

    % get all neighbours (indizies) of vI, excluding vI itself 
    % - adjacency matrix
    vINeighbours = ConnectivityList(:, any(ConnectivityList == vI));
    vINeighbours = unique(vINeighbours,'sorted')';
    vINeighbours = vINeighbours(:,~(vINeighbours == vI));

    vINumNeighbours = size(vINeighbours, 2);

    % set neighbour cols to 1
    % only process upper half of symetrical matrix
    LM(vI, vINeighbours) = -1;

    % set adjM(vI, vI) to number of neighbours
    LM(vI,vI) = vINumNeighbours;

end
    
% compute diffrential coordinates

dX = LM * VertsT0_xyz(1,:)';
dY = LM * VertsT0_xyz(2,:)';
dZ = LM * VertsT0_xyz(3,:)';

% RECONSTRUCTION of absolute coordinates

R = chol(LM, 'lower');
M = R*R';

% add constraints

for vI=1:numVertsFixed
    
    % indizes beachten bei der erstellung der fixed point matrix!!!!! TODO
    
    % TODO continue wenn kein tiefenwert vorhanden (spalte leer???)
    currVFixed = VertsFixedT1_xyz(:,vI);
    constRow = zeros(1,numVerts);
    constRow(1, vI) = 1;
    M = [M; constRow];
    
    dX = [dX; vConst(1,vI)];
    dY = [dY; vConst(2,vI)];
    dZ = [dZ; vConst(3,3vI)];
    
end

% resolve  LGS

recX = M\dX;
recY = M\dY;
recZ = M\dZ;

% new Vertex position format

VertsOut_xyz = [ recX'; recY'; recZ'];


end

