Ply_file = 'SceneFlowTestData/LaplaceTestData/icosahedron.ply';
%Ply_file = 'SceneFlowTestData/LaplaceTestData/cube.ply';
%Ply_file = 'SceneFlowTestData/Pointcloud_sfTestData_mesh_ascii.ply';


% convert ply to processable tri-mesh data
[ Mesh_ConnectivityList, Mesh_Vertex_xyz ] = ply_read ( Ply_file, 'tri' );

% trisurf testmesh
trisurf ( Mesh_ConnectivityList', Mesh_Vertex_xyz(1,:), Mesh_Vertex_xyz(2,:), Mesh_Vertex_xyz(3,:) );
axis equal;

% get fixed points for next frame
Mesh_Vertex_xyz_T1 = [];
Mesh_Vertex_xyz_T1 = Mesh_Vertex_xyz(:,1); % 1 fixed point test

% call deform
Mesh_Vertex_deformed_xyz = laplaceDeform(Mesh_ConnectivityList, Mesh_Vertex_xyz, Mesh_Vertex_xyz_T1);



figure;
trisurf ( Mesh_ConnectivityList', Mesh_Vertex_deformed_xyz(1,:), Mesh_Vertex_deformed_xyz(2,:), Mesh_Vertex_deformed_xyz(3,:) );
axis equal;