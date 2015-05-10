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

load(['Versuch3_V1/Callib_Versuch3_Cut_Complete.mat']);

% -------------------------------------------------------------------------------------------------------

[ Points3D, PointCloud, J1, J2 ] = ReconstructFrame( I1, I2, stereoParams_Versuch3_Cut, 630, 850 );

showPointCloud(PointCloud);

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