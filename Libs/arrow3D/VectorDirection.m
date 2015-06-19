% [x,y] = meshgrid(1:15,1:15);
% tri = delaunay(x,y);
% z = peaks(15);
% [U,V,W] = surfnorm(x,y,z);
% figure
% % the engine
% tf=U<0; % <- color is different for U<0 and U>=0
% quiver3(x(tf),y(tf),z(tf),U(tf),V(tf),W(tf),'color',[1,0,0],'linewidth',0.5)
% hold on
% tf=~tf;
% quiver3(x(tf),y(tf),z(tf),U(tf),V(tf),W(tf),'color',[0,1,0],'linewidth',1)
% trisurf(tri,x,y,z)
% colormap(bone);
% hold off
h = colorbar;
ticks = [1 16:16:64 64:16:128];
ticks(5:6) = [62 66];
set(h, 'YTick', ticks);

labels = num2str(repmat(linspace(min(Z(:)), max(Z(:)), 5), 1, 2)', 2);
set(h, 'YTickLabel', labels)