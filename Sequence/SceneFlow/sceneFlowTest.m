
% load test data

ILeftT0 = im2double(imread('SceneFlowTestData/sfTest_065_left.png'));
ILeftT1 = im2double(imread('SceneFlowTestData/sfTest_066_left.png'));

IRightT0 = im2double(imread('SceneFlowTestData/sfTest_065_right.png'));
IRightT1 = im2double(imread('SceneFlowTestData/sfTest_066_right.png'));

load(['Versuch3_final/Callib_Versuch3_Cut_Complete_L2R.mat']);
load(['SceneFlowTestData/SceneFlowTestData.mat']);