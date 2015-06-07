% ========== get sequences to structs

OrigVidLeft = VideoReader('links_HD.mp4');
OrigVidRight = VideoReader('rechts_HD.mp4');

vidHeightLeft = OrigVidLeft.Height;
vidWidthLeft = OrigVidLeft.Width;
OrigVidLeftStruct = struct('cdata',zeros(vidHeightLeft,vidWidthLeft,3,'double'),'colormap',[]);

vidHeightRight = OrigVidRight.Height;
vidWidthRight = OrigVidRight.Width;
OrigVidRightStruct = struct('cdata',zeros(vidHeightRight,vidWidthRight,3,'double'),'colormap',[]);

% check matching video dimensions
if(vidHeightLeft ~= vidHeightRight || vidWidthLeft ~= vidWidthRight)
    error('video dimension must match!');
end

k = 1;
while hasFrame(OrigVidLeft)
    OrigVidLeftStruct(k).cdata = readFrame(OrigVidLeft);
    k = k+1;
end

k = 1;
while hasFrame(OrigVidRight)
    OrigVidRightStruct(k).cdata = readFrame(OrigVidRight);
    k = k+1;
end

% check matching frame count
if(size(OrigVidLeftStruct, 2) ~= size(OrigVidRightStruct, 2))
    error('video frame count must match!');
end



% ========== get callibration data

load(['Versuch3_final/Callib_Versuch3_Cut_Complete_L2R.mat']);

% ========== vars

numFrames = size(OrigVidLeftStruct, 2);
minZ = 630; 
maxZ = 850;

% reconstructed depth cell
% UVFlowCell = cell(1, size(OrigVidStruct, 2)-1);
% UVFlowCell(1, ind) = {uvMap};

% ========== reconstruct

for fI=1:numFrames
     
    frameLeft = OrigVidLeftStruct(fI).cdata;
    frameRight = OrigVidRightStruct(fI).cdata;
    
    [ PointMap, PointCloud, J1, J2 ] = ReconstructFrame( frameLeft, frameRight, Callib_Versuch3_Cut_Complete_L2R, minZ, maxZ );
    
    % on first frame, create rectified video structs
    if(fI == 1) 
        
        [J1Height, J1Width] = size(J1);
        [J2Height, J2Width] = size(J2);
        
        if(J1Height ~= J2Height || J1Width ~= J2Width)
            error('rectified video dimensions do not match!');
        end
        
        J1Struct = struct('cdata',zeros(J1Height,J1Width,3,'double'),'colormap',[]);
        J2Struct = struct('cdata',zeros(J2Height,J2Width,3,'double'),'colormap',[]);
        
    end
    
    % push rectified frames to structs
    J1Struct(fI).cdata = J1;
    J2Struct(fI).cdata = J2;
    
end


% ========== save data

% write rectified 
