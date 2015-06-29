function [ Mesh_Vertex_Tnext_xyz_filtered ] = nextFrameVertexPositions( Mesh_Vertex_Tcurr_xyz, DepthMap_Tnext, UVFlowMap, K, blDisp)
% Returns the positions of the given verticies in the following frame

% IN
% Mesh_Vertex_Tcurr_xyz: 3xN matrix with vertex postions of the given mesh

% OUT
% Mesh_Vertex_Tnext_xyz:    3xN matrix with the same dimensions as Mesh_Vertex_Tcurr_xyz and the new vertex positions.
%                           Indizies stay consistent. If no depth
%                           information for a given vertex index are found,
%                           it is marked as invalid
% stereoParams:             stereoParameters object. used to get projection
%                           matrix and compute repojection onto the 2D
%                           UVFlowMap
% K, blDisp:                compatible stereoParams, without toolbox
% DepthMap_Tnext:           NxMx3 matrix, with frame image / UVFlowMap
%                           DepthMap_Tnext. Contains depth informations
%                           for certain pixels in frame at T1. May contain
%                           invalid/none information!
% UVFlowMap:                MxNx2 matrix with optical flow vectors from
%                           Tcurr to Tnext

disp('--- starting: nextFrameVertexPositions');

% intrinsic parameters of left camera
% K = stereoParams.CameraParameters1.IntrinsicMatrix';
% projection matrix
M = [K [0;0;0]];
% baseline displacement
% blDisp = round(stereoParams.TranslationOfCamera2(1,1)/2);


% get bounding box for all dimensions
% 3x2 matrix [xMin,xMax;yMin,yMax;zMin,zMax]
% bb = ceil( minmax(Mesh_Vertex_Tcurr_xyz) );
% compatibility
bmax = ceil(max(Mesh_Vertex_Tcurr_xyz,[],2));
bmin = ceil(min(Mesh_Vertex_Tcurr_xyz,[],2));
bb = [bmin bmax];

% add padding to bb
bPadding = 0;
bb(:,1) =  bb(:,1) - bPadding;
bb(:,2) =  bb(:,2) + bPadding;


% Error feedback vars
[UVFlowMapHeight, UVFlowMapWidth] = size(UVFlowMap);
[DepthMap_TnextHeight, DepthMap_TnextWidth] = size(DepthMap_Tnext);

% init vars
numVerts = size(Mesh_Vertex_Tcurr_xyz, 2);
Mesh_Vertex_Tnext_xyz = NaN(3, numVerts);
Mesh_Vertex_Tnext_xyz_filtered = NaN(3, numVerts);


% for each vertex in Mesh_Vertex_Tcurr_xyz
for vI=1:numVerts
    
    % str = sprintf('----  Vertex %d of %d  ----', vI, numVerts);
    % disp(str);
    
    % === get projected 2D-coords of vertex
    % get vertex
    currV = Mesh_Vertex_Tcurr_xyz(:,vI);
    % homogenous coords
    currV = [currV; 1];
    currP = M*currV;
    currP = currP./currP(3,1);
    currP = round(currP(1:2,1)); % rounded values!
     
    
    % ERROR FEEDBACK - check if currP lies in image dimensions (flow map)
    if(currP(1,1) < 1 || currP(1,1) > UVFlowMapWidth || currP(2,1) < 1 || currP(2,1) > UVFlowMapHeight)
        error('Projected 2D-Point coords out of FlowMap dimensions (x: %d, y: %d) | Vertex id: %d', currP(1,1), currP(2,1), vI);
    end
        
    
    % === get flow vector
    flowV = squeeze(UVFlowMap( currP(2,1) , currP(1,1), :)); %y=row, x=col
    flowV = round(flowV); % TODO --- rounding?
    
    % === get next 2D coord
    % adjust baseline displacement in x
    currP(1,1) = currP(1,1) - blDisp;
    nextP = currP + flowV; % TEST - no flow
    
    
    % ERROR FEEDBACK - check if nextP lies in image dimensions (depth map)
    if(nextP(1,1) < 1 || nextP(1,1) > DepthMap_TnextWidth || nextP(2,1) < 1 || nextP(2,1) > DepthMap_TnextHeight)
        error('Flow 2D-Point coords out of DepthMap dimensions (x: %d, y: %d) | Vertex id: %d', nextP(1,1), nextP(2,1), vI);
    end
    
    
    % === get new vertex pos from depth map    
    nextV = squeeze(DepthMap_Tnext( nextP(2,1), nextP(1,1), : ));
    
    % check for invalid entries / no depth information
    isInvalid = any( isnan( nextV ) | isinf( nextV ) );
    
    % if it is valid, check for bounding box
    if(~isInvalid)
        isOutOfBounds = ( ...
            nextV(1,1) < bb(1,1) || nextV(1,1) > bb(1,2) || ...
            nextV(2,1) < bb(2,1) || nextV(2,1) > bb(2,2) || ...
            nextV(3,1) < bb(3,1) || nextV(3,1) > bb(3,2) ...
        );
    end
    
    if(isInvalid || isOutOfBounds) 
    %if(isInvalid) 
        continue;
    else
        Mesh_Vertex_Tnext_xyz(:,vI) = nextV;
    end
    
end

disp('--- filtering contraints');

% scene flow vectors to constraints
[sceneFlowVecs] = sceneFlowVectors( Mesh_Vertex_Tcurr_xyz, Mesh_Vertex_Tnext_xyz ); 
% filter for median
aboveThreshIndx = filterSceneFlowMedian( sceneFlowVecs );

% set contstraints of filtered scene flow vectors to NAN
Mesh_Vertex_Tnext_xyz_filtered(:,aboveThreshIndx) = Mesh_Vertex_Tnext_xyz(:, aboveThreshIndx);



disp('--- done: nextFrameVertexPositions');

end

