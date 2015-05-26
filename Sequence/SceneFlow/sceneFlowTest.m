
% load test data

ILeftT0 = im2double(imread('SceneFlowTestData/sfTest_065_left.png'));
ILeftT1 = im2double(imread('SceneFlowTestData/sfTest_066_left.png'));

IRightT0 = im2double(imread('SceneFlowTestData/sfTest_065_right.png'));
IRightT1 = im2double(imread('SceneFlowTestData/sfTest_066_right.png'));

load(['Versuch3_final/Callib_Versuch3_Cut_Complete_L2R.mat']);
load(['SceneFlowTestData/SceneFlowTestData.mat']);

Ply_file = 'SceneFlowTestData/Pointcloud_sfTestData_mesh_ascii.ply'


% convert ply to processable tri-mesh data
[ Mesh_ConnectivityList, Mesh_Vertex_xyz ] = ply_read ( Ply_file, 'tri' );

% trisurf testmesh
trisurf ( Mesh_ConnectivityList', Mesh_Vertex_xyz(1,:), Mesh_Vertex_xyz(2,:), Mesh_Vertex_xyz(3,:) );
axis equal;