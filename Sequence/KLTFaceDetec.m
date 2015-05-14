% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();

% Read a video frame and run the face detector.
%videoFileReader = vision.VideoFileReader('links.avi');

OrigVid = VideoReader('links_HD.mp4');


% get all video frames and save raw in struct
vidHeight = OrigVid.Height;
vidWidth = OrigVid.Width;
OrigVidStruct = struct('cdata',zeros(vidHeight,vidWidth,3,'double'),'colormap',[]);

k = 1;
while hasFrame(OrigVid)
    OrigVidStruct(k).cdata = readFrame(OrigVid);
    k = k+1;
end

Frame65 = OrigVidStruct(65).cdata;
Frame66 = OrigVidStruct(66).cdata;

bbox = step(faceDetector, Frame65);


% Draw the returned bounding box around the detected face.
Frame65 = insertShape(Frame65, 'Rectangle', bbox);
figure; imshow(Frame65); title('Detected face');

% Convert the first box into a list of 4 points
% This is needed to be able to visualize the rotation of the object.
bboxPoints = bbox2points(bbox(1, :));

% Detect feature points in the face region.
points = detectMinEigenFeatures(rgb2gray(Frame65), 'ROI', bbox);

% Display the detected points.
figure, imshow(Frame65), hold on, title('Detected features');
plot(points);

% Create a point tracker and enable the bidirectional error constraint to
% make it more robust in the presence of noise and clutter.
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

% Initialize the tracker with the initial point locations and the initial
% video frame.
points = points.Location;
initialize(pointTracker, points, Frame65);

% Make a copy of the points to be used for computing the geometric
% transformation between the points in the previous and the current frames
oldPoints = points;

[points, isFound] = step(pointTracker, Frame66);
visiblePoints = points(isFound, :);
oldInliers = oldPoints(isFound, :);

[xform, oldInliers, visiblePoints] = estimateGeometricTransform(...
    oldInliers, visiblePoints, 'similarity', 'MaxDistance', 2);


RoundPoints = round(points);
RoundVisiblePoints = round(visiblePoints);
RoundOldInliers = round(oldInliers);
RoundOldpoints = round(oldPoints);