ww = imread('../../tensorflow-cifar-10/data_set/raw/10043.png')

r = ww(:,:,1)
g = ww(:,:,2)
b = ww(:,:,3)

rgbimage = cat(3, r, g, b);

imwrite(rgbimage, 'test.png');

figure 
colormap(gray(255));
image(rgbimage) 
title('Original image')
axis off

