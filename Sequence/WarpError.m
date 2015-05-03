function WarpErrorStruct = WarpError (OrigVidStruct, BackWarpedVidStruct);

OrigVidStructSize = size(OrigVidStruct, 2);
backWarpedSize = size(BackWarpedVidStruct, 2);

[OrigVidStructHeight, OrigVidStructWidth, colors] = size(OrigVidStruct(1).cdata); 
[backWarpedVidHeight, backWarpedVidWidth, colors] = size(OrigVidStruct(1).cdata); 

if (OrigVidStructSize ~= backWarpedSize + 1)
        error('struct and cell dimensions do not match - cell size should contain 1 frame less');
end
    
if (OrigVidStructHeight ~= backWarpedVidHeight || OrigVidStructWidth ~= backWarpedVidWidth)
    error('Height or width do not match');
end

WarpErrorStruct =  struct('cdata',zeros(OrigVidStructHeight,OrigVidStructWidth,3,'double'),'colormap',[]);
   
 for k=1:backWarpedSize
            
            WarpErrorStruct(k).cdata = OrigVidStruct(k).cdata - BackWarpedVidStruct(k).cdata;
            
 end