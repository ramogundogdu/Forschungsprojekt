function [ VertsOut_xyz ] = laplaceDeform( ConnectivityList, VertsT0_xyz, VertsFixedT1_xyz )
% Coordinate deformation / smoothing through laplacian operation

% ConnectivityList: -
% VertsT0_xyz: 3xN Matrix with Vertex positions at t0
% VertsFixedT1_xyz: 3xN Matrix with fixed/know Vertex positions at t1. Same
% dimensions as VertsT0_xyz; if Position of certain Verticies is unknown,
% inf/nan/0 should be placed at this row index



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
% scaled differ
dX = LM * VertsT0_xyz(1,:)';
dY = LM * VertsT0_xyz(2,:)';
dZ = LM * VertsT0_xyz(3,:)';

% RECONSTRUCTION of absolute coordinates

% R = chol(LM, 'lower');
% M = R*R';

M = LM;

% add constraints

for vI=1:numVertsFixed
    
    % indizes beachten bei der erstellung der fixed point matrix!!!!! TODO
    
    % TODO continue wenn kein tiefenwert vorhanden (spalte leer???)
    currVFixed = VertsFixedT1_xyz(:,vI);
    constRow = zeros(1,numVerts);
    constRow(1, vI) = 100;
    M = [M; constRow];
    
    dX = [dX; currVFixed(1,1)];
    dY = [dY; currVFixed(2,1)];
    dZ = [dZ; currVFixed(3,1)];
    
end

% resolve  LGS

recX = M\dX;
recY = M\dY;
recZ = M\dZ;

% new Vertex position format

VertsOut_xyz = [ recX'; recY'; recZ'];

% TODO - restore positions of known fixed points!!!

end

