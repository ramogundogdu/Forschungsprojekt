function [ SFV, SFV_InterpIndx ] = sceneFlowVectors( VertsFrom, VertsTo, VertsTo_raw )
%SCENEFLOWVECTORS Summary of this function goes here
%   Detailed explanation goes here

% VertsFrom, VertsTo:   Vertex positions, 3xN matrix, with consistent
% indizies
% VertsTo_raw: Vertex positions from nextFramVertexPosisions.m constraints with invalid
% markers, for generating non-interpolated vertex indizies

if( size(VertsFrom,2) ~= size(VertsTo, 2) )
    error('Input matrices must have the same dimensions (number of verticies)');
end

SFV = VertsTo - VertsFrom;
SFV_InterpIndx = any(isnan(VertsTo_raw));

end

