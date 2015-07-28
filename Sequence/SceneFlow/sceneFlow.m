% =============== Load ressources ==================

% Calibration
%load('Versuch3_final/Callib_Versuch3_Cut_Complete_L2R.mat');
load(['Versuch3_final/Callib_Versuch3_Cut_Complete_L2R_EXPORT.mat']);

% depth maps / point clouds for each frame
load('Data_HD_5sec/DepthMapCell_5sec_v1.mat');

% optical flow, left camera, for each frame
load('Data_HD_5sec/OFlow_links_HD_5sec_rect_v1.mat');

% Base mesh
Ply_file = 'SceneFlowTestData/Mesh_Bidirectional_Final.ply';
[ BaseMesh_ConnectivityList, BaseMesh_Verts ] = ply_read ( Ply_file, 'tri' );

% number of frames, according to depth map count
NUM_FRAMES = size(DepthMapCell, 2);

% check for matching frame counts
if(size(UVFlowCell,2) ~= NUM_FRAMES-1)
    error('frame counts of flow- and depth maps do not match!');
end

% scale factor for smoothing
smoothingScale = 0.5;
% index of fixed anchor vertex of the base mesh
fixedVertInd = 3187;

% vertex containers
Verts_Tcurr = BaseMesh_Verts;
Verts_Tnext = [];
% scene flow vectors export cell
SceneFlowVectorCell = cell(2, NUM_FRAMES-1);


disp('======== Ressources loaded - STARTING ========');
tic

% =============== Main loop ==================
figure('MenuBar','none', 'Position', [0,0,2048,2048]);

for FRAME_IND = 1:NUM_FRAMES-1
    
    stat = sprintf('========  Frame %d of %d  ========', FRAME_IND, NUM_FRAMES);
    disp(stat);
    
    NEXT_DEPTHMAP = DepthMapCell{ 1, FRAME_IND + 1 };
    CURR_FLOWCELL = UVFlowCell{1, FRAME_IND };
    
    % get CONSTRAINTS - Vertex positions of depth map in next frame
    VertsConst_Tnext  = nextFrameVertexPositions( Verts_Tcurr, NEXT_DEPTHMAP, CURR_FLOWCELL, K, blDisp);
    
    % interpolate missing vertex positions
    [VertsDeformed_Tnext, weightedLaplace] = laplaceDeformGeometric(BaseMesh_ConnectivityList, Verts_Tcurr, VertsConst_Tnext);
    %[VertsDeformed_Tnext, weightedLaplace] = laplaceDeformGeometricFixed(BaseMesh_ConnectivityList, Verts_Tcurr, VertsConst_Tnext, fixedVertInd);
    
    
    
    % at first frame (Base mesh), build LTL for smoothing
    if(FRAME_IND == 1)
       disp('======== build LTL ========');
       LTL = weightedLaplace' * weightedLaplace;
    end
    
    % OLD: override deformed/interpolated verticies with constraints of depth map to minimize
    % drift (TRYOUT)
    % VertsDeformed_Tnext = replaceVerticies( VertsDeformed_Tnext, VertsConst_Tnext );
    
    % build scene flow vectors
    [sceneFlowVecs, sceneFlowVecs_InterpIndx] = sceneFlowVectors( Verts_Tcurr, VertsDeformed_Tnext, VertsConst_Tnext ); 
    
    % OLD: filter scene flow vectors to median lenght to avoid outliers
    % sceneFlowVecsFiltered = filterSceneFlowMedian( sceneFlowVecs );
    
    SceneFlowVectorCell(1, FRAME_IND) = {sceneFlowVecs};
    SceneFlowVectorCell(2, FRAME_IND) = {sceneFlowVecs_InterpIndx};
   % SceneFlowVectorCell(3, FRAME_IND) = {sceneFlowVecsFiltered};
    
    % smoothing
    Verts_Tnext = laplaceSmooth( BaseMesh_Verts, Verts_Tcurr, LTL, sceneFlowVecs, smoothingScale );
    
    
    
    % Plotting mesh and scene flow vectors
    stat = sprintf('========  Plotting Frame %d  ========', FRAME_IND);
    disp(stat);
    
    % plot mesh with scene flow vectors, safe frame for video
    sfPlot = sceneFlowPlot( BaseMesh_ConnectivityList, Verts_Tnext, sceneFlowVecs, sceneFlowVecs_InterpIndx );
    sfPlotOut(FRAME_IND) = sfPlot;
    
    % save NEXT frame mesh as ply
    stat = sprintf('========  Saving Frame %d  ========', FRAME_IND);
    disp(stat);
    
    ply_filename = sprintf('mesh_frame_%d.ply', FRAME_IND+1);
    ply_data = tri_mesh_to_ply ( Verts_Tnext, BaseMesh_ConnectivityList );
    ply_write ( ply_data, ply_filename,'ascii', 'double' );

    
    
    % set result mesh of this iteration to current mesh of next!
    Verts_Tcurr = Verts_Tnext;
end


% =============== END Main loop ==================

toc
disp('======== DONE ========');

disp('======== Saving Data ========');

% save scene fow vectors
save 'SceneFlowData' SceneFlowVectorCell -v7.3;
% DATA save movie
movie2avi(sfPlotOut, 'SceneFlowData.avi', 'compression', 'None', 'fps', 25, 'quality', 100);

disp('======== REALLY DONE !! ========');