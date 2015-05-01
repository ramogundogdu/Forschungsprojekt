im1 = imread('sq1.png');
im2 = imread('sq2.png');
uv2 = estimate_flow_interface(im1, im2, 'classic+nl-fast');