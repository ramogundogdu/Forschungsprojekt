function [ Mesh_Vertex_Tnext_xyz ] = nextFrameVertexPositions( Mesh_Vertex_Tcurr_xyz, DepthMap_Tnext, UVFlowMap, stereoParams)
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
% DepthMap_Tnext:           NxMx3 matrix, with frame image / UVFlowMap
%                           DepthMap_Tnext. Contains depth informations
%                           for certain pixels in frame at T1. May contain
%                           invalid/none information!
% UVFlowMap:                MxNx2 matrix with optical flow vectors from
%                           Tcurr to Tnext

disp('--- starting: nextFrameVertexPositions');

% intrinsic parameters of left camera
K = stereoParams.CameraParameters1.IntrinsicMatrix';
% projection matrix
M = [K [0;0;0]]


numVerts = size(Mesh_Vertex_Tcurr_xyz, 2);
Mesh_Vertex_Tnext_xyz = NaN(3, numVerts);

% for each vertex in Mesh_Vertex_Tcurr_xyz
for vI=1:numVerts
    
    str = sprintf('----  Vertex %d of %d  ----', vI, numVerts);
    disp(str);
    
    % === get projected 2D-coords of vertex
    % get vertex
    currV = Mesh_Vertex_Tcurr_xyz(:,vI);
    % homogenous coords
    currV = [currV; 1];
    currP = M*currV;
    currP = currP./currP(3,1);
    currP = round(currP(1:2,1)); % rounded values!
    
    % === get flow vector
    flowV = squeeze(UVFlowMap( currP(2,1) , currP(1,1), :));%y=row, x=col
    flowV = round(flowV); % TODO --- rounding?
    
    % === get next 2D coord
    nextP = currP + flowV;
    
    % === get new vertex pos from depth map    
    nextV = squeeze(DepthMap_Tnext( nextP(2,1), nextP(1,1), : ));
    
    % check for invalid entries / no depth information
    isInvalid = any( isnan( nextV ) | isinf( nextV ) );
    
    if(isInvalid) 
        continue;
    else
        Mesh_Vertex_Tnext_xyz(:,vI) = nextV;
    end
    
end

disp('--- done: nextFrameVertexPositions');
%Mesh_Vertex_Tnext_xyz = NaN(size(Mesh_Vertex_Tcurr_xyz));

end

