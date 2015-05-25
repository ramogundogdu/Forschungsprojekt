function [ Points3DSerialized ] = SerializePoints3DFiltered( Points3D, minZ, maxZ )
%SERIALIZEPOINTS3DFILTERED Summary of this function goes here
%   Detailed explanation goes here

    Points3Dx = Points3D(:,:,1);
    Points3Dy = Points3D(:,:,2);
    Points3Dz = Points3D(:,:,3);
    
    Points3Dx = Points3Dx(:);
    Points3Dy = Points3Dy(:);
    Points3Dz = Points3Dz(:);
    
    Points3DSerialized = [Points3Dx, Points3Dy, Points3Dz];
    
    % reduce to finite values
    NoneFiniteIndx = any( isnan( Points3DSerialized ) | isinf( Points3DSerialized ), 2 );
    Points3DSerialized = Points3DSerialized( ~NoneFiniteIndx, : );
    
    % reduce to set z-range
    OutOfRangeIndx =  (Points3DSerialized(:,3) > maxZ | Points3DSerialized(:,3) < minZ);
    Points3DSerialized = Points3DSerialized( ~OutOfRangeIndx, : );

end

