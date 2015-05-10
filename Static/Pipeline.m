%%%%%%%%%%%%%%%%%%%%%
%%
%% Computer Vision Toolbox Mandatory!
%% 
%%%%%%%%%%%%%%%%%%%%%

% ----------- Load Ressources ------------ %

I1 = im2double(imread('links_1.png'));
I2 = im2double(imread('rechts_1.png'));

% I1 = im2double(imread('links_1_masked.png'));
% I2 = im2double(imread('rechts_1_masked.png'));

load(['Versuch3_V1/Callib_Versuch3_Cut_Complete.mat']);


% ----------- Rectification ------------ %

[J1, J2] = rectifyStereoImages(I1, I2, stereoParams_Versuch3_Cut);

% Display the images before rectification.
% figure;
% imshow(stereoAnaglyph(I1, I2), 'InitialMagnification', 50);
% title('Before Rectification');

% Display the images after rectification.
% figure;
% imshow(stereoAnaglyph(J1, J2), 'InitialMagnification', 50);
% title('After Rectification');


% ----------- Disparities ------------ %

%disparityMap = disparity(rgb2gray(J1), rgb2gray(J2), 'DisparityRange', [0 512], 'BlockSize', 5, 'ContrastThreshold', 0.75);
disparityMap = disparity(rgb2gray(J1), rgb2gray(J2), 'DisparityRange', [0 512], 'BlockSize', 5, 'ContrastThreshold', 0.75, 'UniquenessThreshold', 30);

figure;
imshow(disparityMap, [0, 512], 'InitialMagnification', 50);
colormap('jet');
colorbar;
title('Disparity Map');

% ----------- Reconstruction ------------ %


point3D = reconstructScene(disparityMap, stereoParams_Versuch3_Cut);

% Convert from millimeters to meters.
point3D = point3D;

% Plot points between 3 and 7 meters away from the camera.
z = point3D(:, :, 3);
maxZ = 850;
minZ = 630;
zdisp = z;
zdisp(z < minZ | z > maxZ) = NaN;
point3Ddisp = point3D;
point3Ddisp(:,:,3) = zdisp;
showPointCloud(point3Ddisp, J1, 'VerticalAxis', 'Y',...
    'VerticalAxisDir', 'Down' );
xlabel('X');
ylabel('Y');
zlabel('Z');