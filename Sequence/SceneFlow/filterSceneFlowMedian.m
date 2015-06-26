function [ sfVsOut ] = filterSceneFlowMedian( sfVs )
%FILTERSCENEFLOWMEDIAN Summary of this function goes here
%   Detailed explanation goes here

sfVsZero = zeros(size(sfVs));

% get magnituds of vectors
sfVsMags = sqrt(sum(abs(sfVs).^2,1));
threshold = median(sfVsMags);
% logical: longer then threshold?
aboveThresh =  sfVsMags > threshold ;

sfVsOut = sfVs;

sfVsOut(:,aboveThresh) = sfVsZero(:,aboveThresh);



end

