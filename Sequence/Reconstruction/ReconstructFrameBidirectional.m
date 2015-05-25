function [L2R_Points3D, R2L_Points3D, L2R_PointCloud, R2L_PointCloud] = ReconstructFrameBidirectional( ILeft, IRight, StereoParamsL2R, StereoParamsR2L, minZ, maxZ )
% Computes reconstructed pointcloud of stereo image pair
% Reconstruction in both directions - L2R and R2L
% 
% minZ, maxZ: output points are reduced to the specified z-values
% 
% Points3D: Original point cloud computed by visual toolbox - [M N 3] matrix according to image dimensions
% Pointcloud: Pointcloud object, with serialized version prepared for export as ply/obj - .Location: [X Y Z] matrix


    % ----------- Rectification ------------ %

    
    [L2R_ILeft_Rect, L2R_IRight_Rect] = rectifyStereoImages(ILeft, IRight, StereoParamsL2R);
    [R2L_IRight_Rect, R2L_ILeft_Rect] = rectifyStereoImages(IRight, ILeft, StereoParamsR2L);
    
    %     subplot(2,2,1);
    %     title('L2R_ILeft_Rect');
    %     imshow(L2R_ILeft_Rect);
    %     
    %     subplot(2,2,2);
    %     title('L2R_IRight_Rect');
    %     imshow(L2R_IRight_Rect);
    %     
    %     subplot(2,2,3);
    %     title('R2L_ILeft_Rect');
    %     imshow(R2L_ILeft_Rect);
    %     
    %     subplot(2,2,4);
    %     title('R2L_IRight_Rect');
    %     imshow(R2L_IRight_Rect);
    
    
    % ----------- Disparities ------------ %
    % TODO median filtering? - medfilt2()
    
    % last tested: disprange -512|512, blocksize: 9, contrastth: 0.1,
    % uniquenessth: 17
    
    % last tested: disprange -512|512, blocksize: 11, contrastth: 0.25,
    % uniquenessth: 25
    L2R_disparityMap = disparity(rgb2gray(L2R_ILeft_Rect), rgb2gray(L2R_IRight_Rect),...
                            'Method','SemiGlobal',...
                            'DisparityRange', [0 512],...
                            'BlockSize', 11,...
                            'ContrastThreshold', 0.1,...
                            'UniquenessThreshold', 25);
                        
    R2L_disparityMap = disparity(rgb2gray(R2L_IRight_Rect), rgb2gray(R2L_ILeft_Rect),...
                            'Method','SemiGlobal',...
                            'DisparityRange', [-512 0],...
                            'BlockSize', 11,...
                            'ContrastThreshold', 0.1,...
                            'UniquenessThreshold', 25);

        % figure;
        % imshow(L2R_disparityMap, [0, 512], 'InitialMagnification', 50);
        % colormap('jet');
        % colorbar;
        % title('Disparity Map');
        % 
        % figure;
        % imshow(R2L_disparityMap, [-512, 0], 'InitialMagnification', 50);
        % colormap('jet');
        % colorbar;
        % title('Disparity Map');

    
    % ----------- Reconstruction ------------ %
    % values in millimeters
    
    L2R_Points3D = reconstructScene(L2R_disparityMap, StereoParamsL2R);
    R2L_Points3D = reconstructScene(R2L_disparityMap, StereoParamsR2L);
     
    % ----------- serialize and filter infinite/nan values ------------ %

    L2R_Points3DSerialized = SerializePoints3DFiltered(L2R_Points3D, minZ, maxZ);
    R2L_Points3DSerialized = SerializePoints3DFiltered(R2L_Points3D, minZ, maxZ);
 
    % ----------- create exported PointCloud object ------------ %
 
    L2R_PointCloud = pointCloud(L2R_Points3DSerialized);
    R2L_PointCloud = pointCloud(R2L_Points3DSerialized);
    
    L2R_PointCloud = pcdenoise(L2R_PointCloud, 'NumNeighbors', 200);
    R2L_PointCloud = pcdenoise(R2L_PointCloud, 'NumNeighbors', 200);
    
%     %PointCloud = pcdenoise(PointCloud, 'NumNeighbors', 25);
%     PointCloud = pcdenoise(PointCloud, 'NumNeighbors', 200);

end