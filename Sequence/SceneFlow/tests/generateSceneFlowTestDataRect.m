% load data of test sequence - Data_HD_5sec
% currently on external hd
load(['DepthMapCell_5sec_v1']);
load(['links_HD_5sec_rect_v1']);
load(['rechts_HD_5sec_rect_v1']);
load(['OFlow_links_HD_5sec_rect_v1']);


% ========== get specific video frames, rectified

% OrigVidLeft = VideoReader('links_HD.mp4');
% OrigVidRight = VideoReader('rechts_HD.mp4');
% 
% vidHeightLeft = OrigVidLeft.Height;
% vidWidthLeft = OrigVidLeft.Width;
% OrigVidLeftStruct = struct('cdata',zeros(vidHeightLeft,vidWidthLeft,3,'double'),'colormap',[]);
% 
% vidHeightRight = OrigVidRight.Height;
% vidWidthRight = OrigVidRight.Width;
% OrigVidRightStruct = struct('cdata',zeros(vidHeightRight,vidWidthRight,3,'double'),'colormap',[]);
% 
% k = 1;
% while hasFrame(OrigVidLeft)
%     OrigVidLeftStruct(k).cdata = readFrame(OrigVidLeft);
%     k = k+1;
% end
% 
% k = 1;
% while hasFrame(OrigVidRight)
%     OrigVidRightStruct(k).cdata = readFrame(OrigVidRight);
%     k = k+1;
% end
% 
% imwrite(OrigVidLeftStruct(65).cdata, 'sfTest_065_left_rect.png');
% imwrite(OrigVidLeftStruct(66).cdata, 'sfTest_066_left_rect.png');
% 
% imwrite(OrigVidRightStruct(65).cdata, 'sfTest_065_right_rect.png');
% imwrite(OrigVidRightStruct(66).cdata, 'sfTest_066_right_rect.png');