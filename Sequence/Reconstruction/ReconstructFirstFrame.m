% I1 = im2double(imread('links_1.png'));
% I2 = im2double(imread('rechts_1.png'));

% I1 = im2double(imread('links_1_masked.png'));
% I2 = im2double(imread('rechts_1_masked.png'));

% I1 = im2double(imread('links_1_masked2.png'));
% I2 = im2double(imread('rechts_1_masked2.png'));

% I1 = im2double(imread('links_1_masked2_contrast.png'));
% I2 = im2double(imread('rechts_1_masked2_contrast.png'));

LeftVid = VideoReader('links_HD.mp4');
RightVid = VideoReader('rechts_HD.mp4');
I1 = readFrame(LeftVid);
I2 = readFrame(RightVid);

%  == TODO: load updated callibration params!!!

% Left 2 Right Camera Callibration
load(['Versuch3_V1/Callib_Versuch3_Cut_Complete.mat']);
% Right 2 Left Camera Callibration
load(['Versuch3_V1_R2L/Callib_Versuch3_Cut_Complete_R2L.mat']);

% -------------------------------------------------------------------------------------------------------

%[ Points3D, PointCloud, J1, J2 ] = ReconstructFrame( I1, I2, stereoParams_Versuch3_Cut, 630, 850 );

% Right 2 Left Camera Callibration
%[ Points3D, PointCloud, J1, J2 ] = ReconstructFrame( I2, I1, stereoParams_R2L, 630, 850 );

% bidirectional reconstruction
[ L2R_Points3D, R2L_Points3D, L2R_PointCloud, R2L_PointCloud ] = ReconstructFrameBidirectional( I1, I2, stereoParams_Versuch3_Cut, stereoParams_R2L, 630, 850 );
% 
% figure;
% showPointCloud(L2R_PointCloud);
% title('Pointcloud L2R');
% figure;
% showPointCloud(R2L_PointCloud);
% title('Pointcloud R2L');

% -------------------------------------  mergin pointclouds -------------------------------------------

[ MergedPC ] = MergePointclouds( L2R_PointCloud, R2L_PointCloud)
% pcwrite(ptCloud,'teapotOut','PLYFormat','binary');

%------------------------------------------------- OLD ---------
showPointCloud(MergedPC);

% z = Points3D(:, :, 3);
% maxZ = 850;
% minZ = 630;
% zdisp = z;
% zdisp(z < minZ | z > maxZ) = NaN;
% point3Ddisp = Points3D;
% point3Ddisp(:,:,3) = zdisp;
% showPointCloud(point3Ddisp, J1, 'VerticalAxis', 'Y',...
%     'VerticalAxisDir', 'Down' );
% xlabel('X');
% ylabel('Y');
% zlabel('Z');