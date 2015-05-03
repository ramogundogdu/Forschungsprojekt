% COMPUTE OPTICAL FLOW OF SHORT VIDEO SEQUENCE, 
% GENERATE BACKWARPED SEQUENCE RECONSTRUCION BASED ON OPTICAL FLOW MAP,
% SHOW OPTICAL FLOW ERRORS ON FRAME PER FRAME DIFFRENCE OF RECONSTRUCTED
% SEQUNCE


% load original video sequence
% here: hd-version of test sequence
OrigVid = VideoReader('links_HD.mp4');

% get all video frames and save raw in struct
vidHeight = OrigVid.Height;
vidWidth = OrigVid.Width;
OrigVidStruct = struct('cdata',zeros(vidHeight,vidWidth,3,'double'),'colormap',[]);

k = 1;
while hasFrame(OrigVid)
    OrigVidStruct(k).cdata = readFrame(OrigVid);
    k = k+1;
end

% ------------------------------------------------------------
% create data structure for flow uv-maps (1 frame less than video sequence)
UVFlowCell = cell(1, size(OrigVidStruct, 2)-1);
numCellCols = size(UVFlowCell, 2);

% loop through all frame pairs
for ind=1:numCellCols
    
    str = sprintf('----  Flow Image %d of %d  ----', ind, numCellCols);
    disp(str);
        
    curIm = OrigVidStruct(ind).cdata;
    nextIm = OrigVidStruct(ind+1).cdata;
    
    uvMap = estimate_flow_interface(curIm, nextIm, 'classic+nl-fast');
    UVFlowCell(1, ind) = {uvMap};
    
end

% ------------------------------------------------------------
% generate video from optical flow uv-maps for testing purpose
visualizeOpticalFlow( UVFlowCell );

% ------------------------------------------------------------
% compute the backwarped rekonstruktion
BackwarpedStruct = backwardWarpingSequence(OrigVidStruct, UVFlowCell);