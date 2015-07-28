% load cell array with flow information for desired video
% was preprocessed, so look for the folder structure
%
% uv maps for links.avi --> 5sec, 124 uv maps
load(['_ignore/OpticalFlowVisualization/UVFlowCell_5sec_fast.mat']);


% get frames of desired video sequence
% links.avi with 5 sec duration - 125 frames
vid = VideoReader('links.avi');

vidHeight = vid.Height;
vidWidth = vid.Width;
vidStruct = struct('cdata',zeros(vidHeight,vidWidth,3,'double'),'colormap',[]);

k = 1;
while hasFrame(vid)
    vidStruct(k).cdata = readFrame(vid);
    k = k+1;
end

% perform backward warping
BackwarpedStruct = backwardWarpingSequence(vidStruct, UVFlowCell);