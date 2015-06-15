% ========== get all Frames to extract specific pairs

% OrigVidLeft = VideoReader('links_HD.mp4');
% OrigVidRight = VideoReader('rechts_HD.mp4');
% 
% vidHeightLeft = OrigVidLeft.Height;
% vidWidthLeft = OrigVidLeft.Width;
% OrigVidLeftStruct = struct('cdata',zeros(vidHeightLeft,vidWidthLeft,3,'double'),'colormap',[]);
% 
% vidHeightRight = OrigVidRight.Height;
% vidWidthRight = OrigVidRight.Width;
% OrigVidRightStruct = struct('cdata',zeros(vidHeightRight,vidWidthRight,3,'double'),'colormap',[]);
% 
% k = 1;
% while hasFrame(OrigVidLeft)
%     OrigVidLeftStruct(k).cdata = readFrame(OrigVidLeft);
%     k = k+1;
% end
% 
% k = 1;
% while hasFrame(OrigVidRight)
%     OrigVidRightStruct(k).cdata = readFrame(OrigVidRight);
%     k = k+1;
% end
% 
% imwrite(OrigVidLeftStruct(65).cdata, 'sfTest_065_left.png');
% imwrite(OrigVidLeftStruct(66).cdata, 'sfTest_066_left.png');
% 
% imwrite(OrigVidRightStruct(65).cdata, 'sfTest_065_right.png');
% imwrite(OrigVidRightStruct(66).cdata, 'sfTest_066_right.png');



% ========== load base images - processed above

ILeftT0 = im2double(imread('sfTest_065_left.png'));
ILeftT1 = im2double(imread('sfTest_066_left.png'));

IRightT0 = im2double(imread('sfTest_065_right.png'));
IRightT1 = im2double(imread('sfTest_066_right.png'));

% ========== reconstruct both image pairs

load(['Versuch3_final/Callib_Versuch3_Cut_Complete_L2R.mat']);

[ Points3DT0, PointCloudT0 ] = ReconstructFrame( ILeftT0, IRightT0, Callib_Versuch3_Cut_Complete_L2R, 630, 850 );
[ Points3DT1, PointCloudT1 ] = ReconstructFrame( ILeftT1, IRightT1, Callib_Versuch3_Cut_Complete_L2R, 630, 850 );

% ========== compute optical flow for left camera

UVFlowLeftCell = cell(1, 1);
uvMap = estimate_flow_interface(ILeftT0, ILeftT1, 'classic+nl-fast');
UVFlowLeftCell(1, 1) = {uvMap};

% ========== save data

save 'SceneFlowTestData' Points3DT0 PointCloudT0 Points3DT1 PointCloudT1 UVFlowLeftCell;

% ========== export pointcloud at t0 for mesh reconstruction
pcwrite(PointCloudT0,'Pointcloud_sfTestData','PLYFormat','binary');

