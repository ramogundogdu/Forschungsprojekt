function [ MergedPC ] = MergePointclouds( ReferencePC, NewPC )
%MERGEPOINTCLOUDS Summary of this function goes here
%   Detailed explanation goes here


% downsample pointclouds - higher accuracy and performance
% box grid size - all points in this area are sampled into one point
gridSize = 0.2; % 0.5 - 2

fixed = pcdownsample(ReferencePC, 'gridAverage', gridSize);
moving = pcdownsample(NewPC, 'gridAverage', gridSize);

% figure;
% showPointCloud(fixed);
% title('Pointcloud fixed');
% figure;
% showPointCloud(moving);
% title('Pointcloud moving');

tform = pcregrigid(moving, fixed, 'Metric','pointToPoint','Extrapolate', true); %pointToPlane
NewPCAligned = pctransform(NewPC,tform);

mergeSize = 0.45;
MergedPC = pcmerge(ReferencePC, NewPCAligned, mergeSize);

figure;
showPointCloud(MergedPC);

end

