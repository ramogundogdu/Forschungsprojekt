function [ plotFrame ] = sceneFlowPlot( Mesh_connect, Mesh_Verts, sfVs, sfVs_hl_indx )
% plots mesh with flow vectors
% exports frame of plot for collection in movie

% get magnituds of vectors
sfVsMags = sqrt(sum(abs(sfVs).^2,1));
threshold = mean(sfVsMags);
% logical: longer then threshold?
aboveThresh =  sfVsMags > threshold ;

% adjust length
Mesh_Verts = Mesh_Verts * 3;

% interpolated vectors
quiver3(...
    Mesh_Verts(1,sfVs_hl_indx & aboveThresh)',...
    Mesh_Verts(2,sfVs_hl_indx & aboveThresh)',...
    Mesh_Verts(3,sfVs_hl_indx & aboveThresh)',...
    sfVs(1,sfVs_hl_indx & aboveThresh)',...
    sfVs(2,sfVs_hl_indx & aboveThresh)',...
    sfVs(3,sfVs_hl_indx & aboveThresh)',...
'color',[1,0,0],'linewidth',0.5);

hold on

% not interpolated vectors
quiver3(...
    Mesh_Verts(1,~sfVs_hl_indx & aboveThresh)',...
    Mesh_Verts(2,~sfVs_hl_indx & aboveThresh)',...
    Mesh_Verts(3,~sfVs_hl_indx & aboveThresh)',...
    sfVs(1,~sfVs_hl_indx & aboveThresh)',...
    sfVs(2,~sfVs_hl_indx & aboveThresh)',...
    sfVs(3,~sfVs_hl_indx & aboveThresh)',...
'color',[1,1,0],'linewidth',1);

% mesh trisurf
trisurf (Mesh_connect', Mesh_Verts(1,:), Mesh_Verts(2,:), Mesh_Verts(3,:) );
colormap(winter);

hold off

view([360 270]);
axis equal;

plotFrame = getframe(gcf);
% view([360 270]);
% axis equal;
% M(i)=getframe(gcf);
% end
% movie2avi(M,'FaceMovie.avi');


end

