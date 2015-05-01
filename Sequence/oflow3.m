vid = VideoReader('links.avi');

vidHeight = vid.Height;
vidWidth = vid.Width;
vidStruct = struct('cdata',zeros(vidHeight,vidWidth,3,'double'),'colormap',[]);

k = 1;
while hasFrame(vid)
    vidStruct(k).cdata = readFrame(vid);
    k = k+1;
end

% create data structure for flow uv-maps (1 frame less than video sequence
UVFlowCell = cell(1, size(vidStruct, 2)-1);

% info vars
numCellCols = size(UVFlowCell, 2);

% loop through all frame pairs
for ind=1:size(UVFlowCell, 2)
    
    str = sprintf('----  Flow Image %d of %d  ----', ind, numCellCols);
    disp(str);
        
    curIm = vidStruct(ind).cdata;
    nextIm = vidStruct(ind+1).cdata;
    
    uvMap = estimate_flow_interface(curIm, nextIm, 'classic+nl-fast');
    UVFlowCell(1, ind) = {uvMap};
    
end

% generate video from optical flow uv-maps for testing purpose
visualizeOpticalFlow( UVFlowCell );