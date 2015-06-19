% load test data
% ILeftT0 = im2double(imread('SceneFlowTestData/sfTest_065_left_rect.png'));
% ILeftT1 = im2double(imread('SceneFlowTestData/sfTest_066_left_rect.png'));
% 
% IRightT0 = im2double(imread('SceneFlowTestData/sfTest_065_right_rect.png'));
% IRightT1 = im2double(imread('SceneFlowTestData/sfTest_066_right_rect.png'));

load(['SceneFlowTestData/SceneFlowTestData.mat']);

%Ply_file = 'SceneFlowTestData/Pointcloud_sfTestData_mesh_ascii.ply';
Ply_file = 'SceneFlowTestData/BidirectionalMesh_small.ply';

% load callibration data

%load(['Versuch3_final/Callib_Versuch3_Cut_Complete_L2R.mat']);

load(['Versuch3_final/Callib_Versuch3_Cut_Complete_L2R_EXPORT.mat']);

% ========= load base mesh for the test frames (65)

% convert ply to processable tri-mesh data
[ BaseMesh_ConnectivityList, BaseMesh_Verts ] = ply_read ( Ply_file, 'tri' );

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
% information from reconstruction+

% - smooth resulting mesh with "the other" laplace algorithm, in compliance
% to the template mesh (not present in this scenario - should be really
% detailed, based on frame 1 of the sequence, without expressions

% ===========================

% put this in a loop for each frame - with matching vertex matrix and flow
% map
% DepthMapCell_2frames{1,2} --> frame 66
% UVFlowCell_2frames{1,1} --> frame 65 to 66

tic
disp('Ressources loaded - starting');
% 
VertsConst_Tnext  = nextFrameVertexPositions( BaseMesh_Verts, DepthMapCell_2frames{1,2}, UVFlowCell_2frames{1,1}, K, blDisp);
% 
% return weight matrix as well
[Verts_Tnext, weightedLaplace] = laplaceDeformGeometric(BaseMesh_ConnectivityList, BaseMesh_Verts, VertsConst_Tnext);


% AT FIRST FRAME (Base mesh), save LT * L for smoothing
LTL = weightedLaplace' * weightedLaplace;

% % smoothing
 [sceneFlowVecs, sceneFlowVecs_InterpIndx] = sceneFlowVectors( BaseMesh_Verts, Verts_Tnext, VertsConst_Tnext );
% TODO plot vectors at indexes sceneFlowVecs_InterpIndx red, the others ...
% green
% längen der spaltenvektoren: sqrt(sum(abs(sceneFlowVecs).^2,1))
% sfvMed = sceneFlowVecs(:, norms(:, norms > ceil(ans)));
% sfvMed = sceneFlowVecs(:, norms > ans);
<<<<<<< HEAD
N=1; % Number of frames
for i = 1:N
figure;
tf=sceneFlowVecs_InterpIndx==0; % <- color is different for U<0 and U>=0
quiver3(...
    VertsSmoothed_Tnext(1,sceneFlowVecs_InterpIndx)',...
    VertsSmoothed_Tnext(2,sceneFlowVecs_InterpIndx)',...
    VertsSmoothed_Tnext(3,sceneFlowVecs_InterpIndx)',...
    sceneFlowVecs(1,sceneFlowVecs_InterpIndx)',...
    sceneFlowVecs(2,sceneFlowVecs_InterpIndx)',...
    sceneFlowVecs(3,sceneFlowVecs_InterpIndx)',...
    'color',[1,0,0],'linewidth',0.5)
hold on
tf=~tf;
quiver3(...
    VertsSmoothed_Tnext(1,~sceneFlowVecs_InterpIndx)',...
    VertsSmoothed_Tnext(2,~sceneFlowVecs_InterpIndx)',...
    VertsSmoothed_Tnext(3,~sceneFlowVecs_InterpIndx)',...
    sceneFlowVecs(1,~sceneFlowVecs_InterpIndx)',...
    sceneFlowVecs(2,~sceneFlowVecs_InterpIndx)',...
    sceneFlowVecs(3,~sceneFlowVecs_InterpIndx)',...
'color',[0,1,0],'linewidth',1)


trisurf (BaseMesh_ConnectivityList', VertsSmoothed_Tnext(1,:), VertsSmoothed_Tnext(2,:), VertsSmoothed_Tnext(3,:) );
colormap(bone);
hold off
view([360 270]);
axis equal;
M(i)=getframe(gcf);
end
movie2avi(M,'FaceMovie.avi');
=======

% figure;
% tf=sceneFlowVecs_InterpIndx==0; % <- color is different for U<0 and U>=0
% quiver3(...
%     VertsSmoothed_Tnext(1,sceneFlowVecs_InterpIndx)',...
%     VertsSmoothed_Tnext(2,sceneFlowVecs_InterpIndx)',...
%     VertsSmoothed_Tnext(3,sceneFlowVecs_InterpIndx)',...
%     sceneFlowVecs(1,sceneFlowVecs_InterpIndx)',...
%     sceneFlowVecs(2,sceneFlowVecs_InterpIndx)',...
%     sceneFlowVecs(3,sceneFlowVecs_InterpIndx)',...
%     'color',[1,0,0],'linewidth',0.5)
% hold on
% tf=~tf;
% quiver3(...
%     VertsSmoothed_Tnext(1,~sceneFlowVecs_InterpIndx)',...
%     VertsSmoothed_Tnext(2,~sceneFlowVecs_InterpIndx)',...
%     VertsSmoothed_Tnext(3,~sceneFlowVecs_InterpIndx)',...
%     sceneFlowVecs(1,~sceneFlowVecs_InterpIndx)',...
%     sceneFlowVecs(2,~sceneFlowVecs_InterpIndx)',...
%     sceneFlowVecs(3,~sceneFlowVecs_InterpIndx)',...
% 'color',[0,1,0],'linewidth',1)
% 
% 
% trisurf (BaseMesh_ConnectivityList', VertsSmoothed_Tnext(1,:), VertsSmoothed_Tnext(2,:), VertsSmoothed_Tnext(3,:) );
% colormap(bone);
% hold off
% axis equal;

>>>>>>> aad117ef9c46bfff8594c24405869b4fcab4968a
% TODO separate base mesh
VertsSmoothed_Tnext = laplaceSmooth( BaseMesh_Verts, BaseMesh_Verts, LTL, sceneFlowVecs, 0.25 );

%write ply file
ply_data = tri_mesh_to_ply ( VertsSmoothed_Tnext, BaseMesh_ConnectivityList );
plyName = sprintf('frame_%d.ply', 22);
ply_write ( ply_data, plyName,'ascii', 'double' );


disp('done!');
toc

% save 'sceneFlowTest_firstInterpolationRun' Mesh_Vertex_Tnext_xyz Mesh_Vertex_deformed_xyz -v7.3;
% ===========================

% OLD
trisurf ( BaseMesh_ConnectivityList', BaseMesh_Verts(1,:), BaseMesh_Verts(2,:), BaseMesh_Verts(3,:) );
axis equal;

figure;
trisurf ( BaseMesh_ConnectivityList', VertsConst_Tnext(1,:), VertsConst_Tnext(2,:), VertsConst_Tnext(3,:) );
axis equal; 

figure;
trisurf ( BaseMesh_ConnectivityList', Verts_Tnext(1,:), Verts_Tnext(2,:), Verts_Tnext(3,:) );
axis equal;

figure;
trisurf ( BaseMesh_ConnectivityList', VertsSmoothed_Tnext(1,:), VertsSmoothed_Tnext(2,:), VertsSmoothed_Tnext(3,:) );
axis equal;

