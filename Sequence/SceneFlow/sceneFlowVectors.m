function [ SFV ] = sceneFlowVectors( VertsFrom, VertsTo )
%SCENEFLOWVECTORS Summary of this function goes here
%   Detailed explanation goes here

% VertsFrom, VertsTo:   Vertex positions, 3xN matrix, with consistent
% indizies

if( size(VertsFrom,2) ~= size(VertsTo, 2) )
    error('Input matrices must have the same dimensions (number of verticies)');
end

SFV = VertsTo - VertsFrom;


end

