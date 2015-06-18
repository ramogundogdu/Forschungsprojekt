[x,y] = meshgrid(1:15,1:15);
tri = delaunay(x,y);
z = peaks(15);
[U,V,W] = surfnorm(x,y,z);
figure
% the engine
tf=U<0; % <- color is different for U<0 and U>=0
quiver3(x(tf),y(tf),z(tf),U(tf),V(tf),W(tf),'color',[1,0,0],'linewidth',0.5)
hold on
tf=~tf;
quiver3(x(tf),y(tf),z(tf),U(tf),V(tf),W(tf),'color',[0,1,0],'linewidth',1)
trisurf(tri,x,y,z)
colormap(bone);
hold off


% 
% a = [2 3 5];
% b = [1 1 0];
% c = a+b;
% 
% starts = zeros(3,3);
% ends = [a;b;c];
% tri = delaunay(a,b);
% c = peaks(15);
% [U,V,W] = surfnorm(a,b,c);
% figure
% quiver3(starts(a, b, c, U, V, W))
% hold on
% trisurf(tri,a,b,c)
% hold off
