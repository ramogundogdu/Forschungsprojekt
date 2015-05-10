function [ Points3D, PointCloud, J1, J2 ] = ReconstructFrame( I1, I2, StereoParmas, minZ, maxZ )
% Computes reconstructed pointcloud of stereo image pair
% 
% minZ, maxZ: output points are reduced to the specified z-values
% 
% Points3D: Original point cloud computed by visual toolbox - [M N 3] matrix according to image dimensions
% Pointcloud: Pointcloud object, with serialized version prepared for export as ply/obj - .Location: [X Y Z] matrix


    % ----------- Rectification ------------ %

    [J1, J2] = rectifyStereoImages(I1, I2, StereoParmas);

    % ----------- Disparities ------------ %

%     disparityMap = disparity(rgb2gray(J1), rgb2gray(J2),...
%                              'DisparityRange', [0 512],...
%                              'BlockSize', 5,...
%                              'ContrastThreshold', 0.75);
    
%     disparityMap = disparity(rgb2gray(J1), rgb2gray(J2),...
%                             'DisparityRange', [0 512],...
%                             'BlockSize', 5,...
%                             'ContrastThreshold', 0.75,...
%                             'UniquenessThreshold', 30);
                        
    disparityMap = disparity(rgb2gray(J1), rgb2gray(J2),...
                            'Method','SemiGlobal',...
                            'DisparityRange', [0 512],...
                            'BlockSize', 9,...
                            'ContrastThreshold', 0.1,...
                            'UniquenessThreshold', 17);

    % figure;
    % imshow(disparityMap, [0, 512], 'InitialMagnification', 50);
    % colormap('jet');
    % colorbar;
    % title('Disparity Map');

    % ----------- Reconstruction ------------ %

    % values in millimeters
    Points3D = reconstructScene(disparityMap, StereoParmas);
     
    % ----------- serialize and filter infinite/nan values ------------ %
    
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
    
    
    % ----------- create exported PointCloud object ------------ %
 
    PointCloud = pointCloud(Points3DSerialized);
    PointCloud = pcdenoise(PointCloud, 'NumNeighbors', 25);

end

