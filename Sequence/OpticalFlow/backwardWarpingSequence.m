function BackwarpedStruct = backwardWarpingSequence( OrigVidStruct, UVFlowCell )

%
%   Produces a backwarped reconstruction of OrigVidStruct
%   based on the UVFlowCell optical flow information

%   OrigVidstruct:  struct with video sequence frame inforamtion
%                   1 x N sized

%   UVFlowCell:     cell array which includes uv-maps with optical flow
%                   information based on the algorithms of Deqing Sun, 
%                   Department of Computer Science, Brown University
%                   1 x N-1 sized

    disp('--- backward warping of sequence ---');
    
    vidStructSize = size(OrigVidStruct, 2);
    flowCellSize = size(UVFlowCell, 2);
    
    % check for proper dimensions of input arguments
    if (vidStructSize ~= flowCellSize + 1)
        error('struct and cell dimensions do not match - cell size should contain 1 frame less');
    end

    % create output struct 
    % TODO more sophisticated error detection of input args (e.g. matching
    % image dimensions etc.)
    [vidHeight, vidWidth, colors] = size(OrigVidStruct(1).cdata);

    BackwarpedStruct =  struct('cdata',zeros(vidHeight,vidWidth,3,'double'),'colormap',[]);

    for k=1:flowCellSize
        currFrame = OrigVidStruct(k).cdata;
        nextFrame = OrigVidStruct(k+1).cdata;
        uvMap = UVFlowCell{1,k};
        
        BackwarpedStruct(k).cdata = backwardWarping( currFrame, nextFrame, uvMap);
    end
    
    disp('--- backward warping DONE ---');

end

