vid = VideoReader('links.avi');

vidHeight = vid.Height;
vidWidth = vid.Width;
vidStruct = struct('cdata',zeros(vidHeight,vidWidth,3,'double'),'colormap',[]);

k = 1;
while hasFrame(vid)
    vidStruct(k).cdata = readFrame(vid);
    k = k+1;
end

FlowMatCell = cell(1, size(vidStruct, 2));
%method = 'Horn-Schunck';
% method = 'Lucas-Kanade';

%opticalFlow = vision.OpticalFlow('Method',method,'OutputValue','Horizontal and vertical components in complex form', 'Smoothness', 100);

% curIm = vidStruct(1).cdata;
% FlowMat = step(opticalFlow,curIm);
% 
% for ind=2:size(FlowMatCell, 2)
%     curIm = vidStruct(ind).cdata;
%     FlowMat = step(opticalFlow,curIm);
%     FlowMatCell(1, ind) = {FlowMat};
% end

%


uv2 = estimate_flow_interface(vidStruct(1).cdata, vidStruct(2).cdata, 'classic+nl-fast');