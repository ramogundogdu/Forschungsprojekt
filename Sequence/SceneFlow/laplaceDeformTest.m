%Ply_file = 'SceneFlowTestData/LaplaceTestData/icosahedron.ply';
%Ply_file = 'SceneFlowTestData/LaplaceTestData/cube.ply';
Ply_file = 'SceneFlowTestData/Pointcloud_sfTestData_mesh_ascii.ply';


% convert ply to processable tri-mesh data
[ Mesh_ConnectivityList, Mesh_Vertex_xyz ] = ply_read ( Ply_file, 'tri' );

% trisurf testmesh
% trisurf ( Mesh_ConnectivityList', Mesh_Vertex_xyz(1,:), Mesh_Vertex_xyz(2,:), Mesh_Vertex_xyz(3,:) );
% axis equal;


% adjazenz matrix berechnen

numVerts = size(Mesh_Vertex_xyz, 2);
LM = zeros(numVerts, numVerts);

% ------ check computation time

% === compute upper half only and complete the matrix with transposed

tic();
% for each vertex  build adjacency row
% for vI=1:numVerts
%     
%     % get all neighbours (indizies) of vI, excluding vI itself 
%     % - adjacency matrix
%     vINeighbours = Mesh_ConnectivityList(:, any(Mesh_ConnectivityList == vI));
%     vINeighbours = unique(vINeighbours,'sorted')';
%     vINeighbours = vINeighbours(:,~(vINeighbours == vI));
%     
%     vINumNeighbours = size(vINeighbours, 2);
%     
%     % set neighbour cols to 1
%     % only process upper half of symetrical matrix
%     LM(vI, vINeighbours(vINeighbours > vI) ) = 1;
%     
%     % set adjM(vI, vI) to number of neighbours
%     LM(vI,vI) = vINumNeighbours;
%     
% end
% 
% % extract diagonal (num of neighbours), add lower half, restore diagonal
% LMdiag = diag(LM);
% LM = LM + LM';
% LM(eye(numVerts)==1) = LMdiag;


% === compute full matrix (seems faster!)

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
    LM(vI, vINeighbours) = 1;
    
    % set adjM(vI, vI) to number of neighbours
    LM(vI,vI) = vINumNeighbours;
    
end


toc();
