im1 = imread('frame10.png');
im2 = imread('frame11.png');
uv2 = estimate_flow_interface(im1, im2, 'classic++');