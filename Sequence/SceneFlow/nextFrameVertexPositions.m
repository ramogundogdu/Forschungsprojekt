function [ Mesh_Vertex_Tnext_xyz ] = nextFrameVertexPositions( Mesh_Vertex_Tcurr_xyz, UVFlowMap, stereoParams)
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
% UVFlowMap:                MxNx2 matrix with optical flow vectors from
%                           Tcurr to Tnext

Mesh_Vertex_Tnext_xyz = NaN(size(Mesh_Vertex_Tcurr_xyz));

end

