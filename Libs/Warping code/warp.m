%input first frame, second frame, flow image
function [ warpIm ] = warp( im1,im2, flowIm )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m n c] = size(im);
warpIm = zeros(m, n, c,'uint8');
%reconstruct im1 as warpIm from im2 and flow vector
for y=1:m
        for x= 1:n           
            %location to look up   
            dispVector = flowIm(x,y);%datenstruktur anpassen
            pWarped = [x y]'+dispVector;%datenstruktur anpassen
          %do bilinear interpolation, http://en.wikipedia.org/wiki/Bilinear_interpolation
            x1 = floor(pWarped(1));
            y1 = floor(pWarped(2));
            dx = pWarped(1) - x1;
            dy = pWarped(2) - y1;
            color = zeros(3,1,'uint8');
            if( x1 > 0 && y1 > 0 && x1 < n && y1 < m)
                warpIm(y,x,:)  = im2(y1,x1,:)*(1-dx)*(1-dy)+im2(y1,x1+1,:)*(dx)*(1-dy)+im2(y1+1,x1+1,:)*(dx)*(dy)+im2(y1+1,x1,:)*dy*(1-dx);

            end

                      
        end
    end
end