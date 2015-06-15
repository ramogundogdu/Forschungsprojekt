% load data of test sequence - Data_HD_5sec
% currently on external hd

% load('DepthMapCell_5sec_v1.mat');
% load('links_HD_5sec_rect_v1.mat');
% load('rechts_HD_5sec_rect_v1.mat');
% load('OFlow_links_HD_5sec_rect_v1.mat');


% ========== write images left/right for 2 frames

% imwrite(RectVidLeftStruct(65).cdata, 'sfTest_065_left_rect.png');
% imwrite(RectVidLeftStruct(66).cdata, 'sfTest_066_left_rect.png');
% 
% imwrite(RectVidRightStruct(65).cdata, 'sfTest_065_right_rect.png');
% imwrite(RectVidRightStruct(66).cdata, 'sfTest_066_right_rect.png');

% ========== load base images - processed above

ILeftT0 = im2double(imread('sfTest_065_left_rect.png'));
ILeftT1 = im2double(imread('sfTest_066_left_rect.png'));

IRightT0 = im2double(imread('sfTest_065_right_rect.png'));
IRightT1 = im2double(imread('sfTest_066_right_rect.png'));

% ========== Depth maps for 2 frames

DepthMapCell_2frames = DepthMapCell(:,65:66);

% ========== Optical flow between the 2 frames

UVFlowCell_2frames = UVFlowCell(:,65);

% ========== save depth and optical flow data

save 'SceneFlowTestData' DepthMapCell_2frames UVFlowCell_2frames;