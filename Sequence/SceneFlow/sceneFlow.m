% =============== Load ressources ==================

% Callibration
load('Versuch3_final/Callib_Versuch3_Cut_Complete_L2R.mat');

% depth maps / point clouds for each frame
load('Data_HD_5sec/DepthMapCell_5sec_v1.mat');

% optical flow, left camera, for each frame
load('Data_HD_5sec/OFlow_links_HD_5sec_rect_v1.mat');

% Base mesh
Ply_file = 'SceneFlowTestData/Pointcloud_sfTestData_mesh_ascii.ply';
[ BaseMesh_ConnectivityList, BaseMesh_Verts ] = ply_read ( Ply_file, 'tri' );

% number of frames, according to depth map count
NUM_FRAMES = size(DepthMapCell, 2);
% scale factor for smoothing
smoothingScale = 0.5;

% vertex containers
Verts_Tcurr = BaseMesh_Verts;
Verts_Tnext = [];


disp('======== Ressources loaded - STARTING ========');
tic

% =============== Main loop ==================


for FRAME_IND = 1:NUM_FRAMES-1
    
    NEXT_DEPTHMAP = DepthMapCell{ 1, FRAME_IND + 1 };
    CURR_FLOWCELL = UVFlowCell{1, FRAME_IND };
    
    % get CONSTRAINTS - Vertex positions of depth map in next frame
    VertsConst_Tnext  = nextFrameVertexPositions( Verts_Tcurr, NEXT_DEPTHMAP, CURR_FLOWCELL, Callib_Versuch3_Cut_Complete_L2R);
    
    % interpolate missing vertex positions
    [VertsDeformed_Tnext, weightedLaplace] = laplaceDeformGeometric(BaseMesh_ConnectivityList, Verts_Tcurr, VertsConst_Tnext);
    
    % at first frame (Base mesh), build LTL for smoothing
    if(FRAME_IND == 1)
       LTL = weightedLaplace' * weightedLaplace;
    end
    
    % build scene flow vectors
    [sceneFlowVecs, sceneFlowVecs_InterpIndx] = sceneFlowVectors( Verts_Tcurr, VertsDeformed_Tnext, VertsConst_Tnext ); 
    % TODO plot vectors at indexes sceneFlowVecs_InterpIndx red, the others ...
    % green
    
    Verts_Tnext = laplaceSmooth( BaseMesh_Verts, Verts_Tcurr, LTL, sceneFlowVecs, smoothingScale );
    
    % save NEXT frame mesh as ply
    ply_filename = sprintf('mesh_frame_%d.ply', FRAME_IND+1);
    ply_data = tri_mesh_to_ply ( Verts_Tnext, BaseMesh_ConnectivityList );
    ply_write ( ply_data, ply_filename,'ascii', 'double' );

    % set result mesh of this iteration to current mesh of next!
    Verts_Tcurr = Verts_Tnext;
end


% =============== END Main loop ==================

toc
disp('======== DONE!!! ========');
