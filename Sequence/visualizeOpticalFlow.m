function visualizeOpticalFlow( UVFlowCell )

% creates video file of uv-flow images created with the optical flow 
% algorithm of Deqing Sun, Department of Computer Science, Brown University

    % create color maps of uv-maps inside the UVFlowCell and save them 
    % in struct for video file writing
    
    % get uv-map dimensions by first flow frame
    [vidHeight, vidWidth, uv] = size(UVFlowCell{1,1});
    flowStruct = struct('cdata',zeros(vidHeight,vidWidth,3,'double'),'colormap',[]);

    for k=1:size(UVFlowCell, 2)
        flowStruct(k).cdata = uint8(flowToColor( UVFlowCell{1,k} ));
    end

    % create video writertestvidout = VideoWriter('newvid.mp4');
    flowVidWriter = VideoWriter('flowVisualization');
    flowVidWriter.FrameRate = 25;
    flowVidWriter.Quality = 50;

    open(flowVidWriter);
    writeVideo(flowVidWriter, flowStruct);
    close(flowVidWriter);


end

