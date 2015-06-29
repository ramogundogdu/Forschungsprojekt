function [ aboveThreshIndx ] = filterSceneFlowMedian( sfVs )
%FILTERSCENEFLOWMEDIAN Summary of this function goes here
%   Detailed explanation goes here

sfVsZero = zeros(size(sfVs));

% get magnituds of vectors
sfVsMags = sqrt(sum(abs(sfVs).^2,1));
nonNanIndx = ~isnan(sfVsMags);
threshold = median(sfVsMags(:, nonNanIndx));


% logical: longer then threshold?
aboveThreshIndx =  sfVsMags > threshold ;

% OLD - currently only valid indizies are needed
% sfVs dont have to be altered---
% sfVsOut = sfVs;
% sfVsOut(:,aboveThresh) = sfVsZero(:,aboveThresh);

end

