 Ply_file = 'SceneFlowTestData/LaplaceTestData/icosahedron.ply';
%Ply_file = 'SceneFlowTestData/LaplaceTestData/cube.ply';
% Ply_file = 'SceneFlowTestData/LaplaceTestData/dart.ply';
%Ply_file = 'SceneFlowTestData/LaplaceTestData/sandal.ply';
%Ply_file = 'SceneFlowTestData/LaplaceTestData/sphere.ply';
%Ply_file = 'SceneFlowTestData/LaplaceTestData/teapot.ply';
%Ply_file = 'SceneFlowTestData/Pointcloud_sfTestData_mesh_ascii.ply';


% convert ply to processable tri-mesh data
[ Mesh_ConnectivityList, Mesh_Vertex_xyz ] = ply_read ( Ply_file, 'tri' );


% --------------------
% 
% Mesh_Vertex_xyz = [
%     
% 0, 2, 2.5, 1;
% 0, 1, 0, -2;
% 3, 0, 0, 0
%     
% ]
% Mesh_ConnectivityList = [
% 
% 1, 1;
% 2, 3;
% 3, 4
% 
% ]

%----------------------
% trisurf testmesh
trisurf ( Mesh_ConnectivityList', Mesh_Vertex_xyz(1,:), Mesh_Vertex_xyz(2,:), Mesh_Vertex_xyz(3,:) );
axis equal;

% get fixed points for next frame
Mesh_Vertex_xyz_T1 = [];
Mesh_Vertex_xyz_T1 = Mesh_Vertex_xyz(:,1); % 1 fixed point test

% Mesh_Vertex_xyz_T1 = [];
% Mesh_Vertex_xyz_T1 = Mesh_Vertex_xyz(:,1:2); % 2 fixed points
% Mesh_Vertex_xyz_T1(:,2) = Mesh_Vertex_xyz_T1(:,2) + [10;10;0]

% call deform
Mesh_Vertex_deformed_xyz = laplaceDeformGeometric(Mesh_ConnectivityList, Mesh_Vertex_xyz, Mesh_Vertex_xyz_T1);


% 
figure;
trisurf ( Mesh_ConnectivityList', Mesh_Vertex_deformed_xyz(1,:), Mesh_Vertex_deformed_xyz(2,:), Mesh_Vertex_deformed_xyz(3,:) );
axis equal;