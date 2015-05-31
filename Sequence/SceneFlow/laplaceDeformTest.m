Ply_file = 'SceneFlowTestData/LaplaceTestData/icosahedron.ply';
%Ply_file = 'SceneFlowTestData/LaplaceTestData/cube.ply';
%Ply_file = 'SceneFlowTestData/Pointcloud_sfTestData_mesh_ascii.ply';


% convert ply to processable tri-mesh data
[ Mesh_ConnectivityList, Mesh_Vertex_xyz ] = ply_read ( Ply_file, 'tri' );

% trisurf testmesh
% trisurf ( Mesh_ConnectivityList', Mesh_Vertex_xyz(1,:), Mesh_Vertex_xyz(2,:), Mesh_Vertex_xyz(3,:) );
% axis equal;


% compute Laplace matrix

numVerts = size(Mesh_Vertex_xyz, 2);
LM = zeros(numVerts, numVerts);

    % for each vertex  build adjacency row
    for vI=1:numVerts

        % get all neighbours (indizies) of vI, excluding vI itself 
        % - adjacency matrix
        vINeighbours = Mesh_ConnectivityList(:, any(Mesh_ConnectivityList == vI));
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

dX = LM * Mesh_Vertex_xyz(1,:)';
dY = LM * Mesh_Vertex_xyz(2,:)';
dZ = LM * Mesh_Vertex_xyz(3,:)';

% RECONSTRUCTION of absolute coordinates

    R = chol(LM);
    M = R*R';
    
    % add constraints

    % testing purposes - chose v1 as fixed / constraint
    % later we can use Mesh_Vertex_xyz'
    vConst = Mesh_Vertex_xyz(:,1)';
    
    % add constraints
    constRow = zeros(1,numVerts);
    constRow(1,1) = 1;
    M = [M; constRow];
    
    % add known absolute coords to delta coords
    dX = [dX; vConst(1,1)];
    dY = [dY; vConst(1,2)];
    dZ = [dZ; vConst(1,3)];
    
    % resolve normal equations
    
%     xAbs = M * dX;
%     yAbs = M * dY;
%     zAbs = M * dZ;
    
    
    
    



