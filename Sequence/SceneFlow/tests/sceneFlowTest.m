% load test data
% ILeftT0 = im2double(imread('SceneFlowTestData/sfTest_065_left_rect.png'));
% ILeftT1 = im2double(imread('SceneFlowTestData/sfTest_066_left_rect.png'));
% 
% IRightT0 = im2double(imread('SceneFlowTestData/sfTest_065_right_rect.png'));
% IRightT1 = im2double(imread('SceneFlowTestData/sfTest_066_right_rect.png'));

load(['SceneFlowTestData/SceneFlowTestData.mat']);

Ply_file = 'SceneFlowTestData/Pointcloud_sfTestData_mesh_ascii.ply'

% load callibration data
load(['Versuch3_final/Callib_Versuch3_Cut_Complete_L2R.mat']);


% ========= load base mesh for the test frames (65)

% convert ply to processable tri-mesh data
[ Mesh_ConnectivityList, Mesh_Vertex_xyz ] = ply_read ( Ply_file, 'tri' );

% ===========================

% TODO

% - find vertex positions at T1 --> create empty Mesh_Vertex structure with
% the same dimensions like at T0
% FOR EACH VERTEX
    % - reproject 3d vertex position onto the optical flow map of frame at T0 (left
    % image, frame 65)
    % - get the 2d displacement vector at flow map position
    % - find the new 2d coordinate of frame at T1 (left image, frame 66)
    % - get depth info / 3d-coordinat from depth map at T1
        % - IF depth info is present --> write at index (as constraint for
        % laplace deformation)
        % - ELSE (no depth info) --> mark as invalid at this index!
% RESULT
% Vertex positions at T1 as constraints for laplace geometric deformation
% (laplaceDeformGeomatric.m)

% - laplace deform the mesh at T0 to T1, thus interpolating missing depth
% information from reconstruction
% TODO in laplaceDeformGeomatric.m: check for invalid indizies! --> weight
% matrix

% - smooth resulting mesh with "the other" laplace algorithm, in compliance
% to the template mesh (not present in this scenario - should be really
% detailed, based on frame 1 of the sequence, without expressions

% ===========================

% put this in a loop for each frame - with matching vertex matrix and flow
% map
Mesh_Vertex_Tnext_xyz  = nextFrameVertexPositions( Mesh_Vertex_xyz, UVFlowCell_2frames{1,1}, Callib_Versuch3_Cut_Complete_L2R);


% ===========================

% OLD

% convert ply to processable tri-mesh data
% [ Mesh_ConnectivityList, Mesh_Vertex_xyz ] = ply_read ( Ply_file, 'tri' );
% 
% % trisurf testmesh
% trisurf ( Mesh_ConnectivityList', Mesh_Vertex_xyz(1,:), Mesh_Vertex_xyz(2,:), Mesh_Vertex_xyz(3,:) );
% axis equal;