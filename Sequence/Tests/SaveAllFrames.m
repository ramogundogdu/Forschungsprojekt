
clc;
close all;
clear all;

filename = 'links_HD.mp4';

mov = VideoReader(filename);

opFolder = fullfile(cd, 'AllVidFrames');
%if  not existing
if ~exist(opFolder, 'dir')
    mkdir(opFolder);
end

%getting no of frames
numFrames = mov.NumberOfFrames;

numFramesWritten = 0;


for t = 1 : numFrames
    currFrame = read(mov, t);
    opBaseFileName = sprintf('%3.3d.png', t);
    opFullFileName = fullfile(opFolder, opBaseFileName);
    imwrite(currFrame, opFullFileName, 'png');   %saving as 'png' file
    
    progIndication = sprintf('Wrote frame %4d of %d.', t, numFrames);
    disp(progIndication);
    numFramesWritten = numFramesWritten + 1;
end
progIndication = sprintf('Wrote %d frames to folder "%s"',numFramesWritten, opFolder);
disp(progIndication);
