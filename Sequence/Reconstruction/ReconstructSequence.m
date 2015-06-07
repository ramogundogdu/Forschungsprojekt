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
% 2xN cell array - 1st Row: Depth map at frame N, 2nd Row: PointCloud at
% frame N
DepthMapCell = cell(2, numFrames);

% ========== reconstruction and rectification

% start at 1 is mandatory!
for fI=1:2
     
    frameLeft = OrigVidLeftStruct(fI).cdata;
    frameRight = OrigVidRightStruct(fI).cdata;
    
    [ PointMap, PointCloud, J1, J2 ] = ReconstructFrame( frameLeft, frameRight, Callib_Versuch3_Cut_Complete_L2R, minZ, maxZ );
    
    % save depth infos in DepthMapCell
    DepthMapCell(1, fI) = {PointMap};
    DepthMapCell(2, fI) = {PointCloud};
    
    % on first frame, create rectified video structs
    if(fI == 1) 
        
        [J1Height, J1Width] = size(J1);
        [J2Height, J2Width] = size(J2);
        
        if(J1Height ~= J2Height || J1Width ~= J2Width)
            error('rectified video dimensions do not match!');
        end
        
        RectVidLeftStruct = struct('cdata',zeros(J1Height,J1Width,3,'double'),'colormap',[]);
        RectVidRightStruct = struct('cdata',zeros(J2Height,J2Width,3,'double'),'colormap',[]);
        
    end
    
    % push rectified frames to structs
    RectVidLeftStruct(fI).cdata = im2double(J1);
    RectVidRightStruct(fI).cdata = im2double(J2);
    
end


% ========== save data

save 'DepthMapCell_5sec_v1' DepthMapCell;
save 'links_HD_5sec_rect_v1' RectVidLeftStruct;
save 'rechts_HD_5sec_rect_v1' RectVidRightStruct;

