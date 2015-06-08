% using "RectVidLeftStruct" generated in ReconstructSequence.m !!

load(['links_HD_5sec_rect_v1.mat']);

% create data structure for flow uv-maps (1 frame less than video sequence)
UVFlowCell = cell(1, size(RectVidLeftStruct, 2)-1);
numCellCols = size(UVFlowCell, 2);

% loop through all frame pairs
for ind=1:numCellCols
    
    str = sprintf('----  Flow Image %d of %d  ----', ind, numCellCols);
    disp(str);
        
    curIm = RectVidLeftStruct(ind).cdata;
    nextIm = RectVidLeftStruct(ind+1).cdata;
    
    uvMap = estimate_flow_interface(curIm, nextIm, 'classic+nl-fast');
    UVFlowCell(1, ind) = {uvMap};
    
end

disp(' === Optical Flow processing DONE! === ');

save 'OFlow_links_HD_5sec_rect_v1' UVFlowCell -v7.3;