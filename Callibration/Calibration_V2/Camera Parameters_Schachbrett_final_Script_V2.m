% Auto-generated by stereoCalibrator app on 07-Apr-2015
%-------------------------------------------------------


% Define images to process
imageFileNames1 = {'/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_01.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_02.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_03.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_04.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_05.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_09.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_10.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_11.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_15.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_16.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_17.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_18.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_20.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_21.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_22.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_23.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_24.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/linksScreenshots/links_25.png',...
    };
imageFileNames2 = {'/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_01.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_02.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_03.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_04.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_05.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_09.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_10.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_11.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_15.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_16.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_17.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_18.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_20.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_21.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_22.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_23.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_24.png',...
    '/Users/jovanastojic/Desktop/Studium/Master/MIM2/Forschungsprojekt/Aufnahmen_Screenshots/Schachbrett_final/rechtsScreenhots/rechts_25.png',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames1, imageFileNames2);

% Generate world coordinates of the checkerboard keypoints
squareSize = 37;  % in units of 'mm'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[stereoParams, pairsUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 3, 'WorldUnits', 'mm');

% View reprojection errors
h1=figure; showReprojectionErrors(stereoParams, 'BarGraph');

% Visualize pattern locations
h2=figure; showExtrinsics(stereoParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, stereoParams);

% You can use the calibration data to rectify stereo images.
I1 = imread(imageFileNames1{1});
I2 = imread(imageFileNames2{1});
[J1, J2] = rectifyStereoImages(I1, I2, stereoParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('StereoCalibrationAndSceneReconstructionExample')
