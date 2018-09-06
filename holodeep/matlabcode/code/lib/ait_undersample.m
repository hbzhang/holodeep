%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function Developed by Fahd A. Abbasi.
% Department of Electrical and Electronics Engineering, University of
% Engineering and Technology, Taxila, PAKISTAN.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% The function undersamples an image according with the user requirement.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% USAGE (SAMPLE CODE)
%
%
      pic = imread('cameraman.tif');
      [x_ori,y_ori,z_ori] = size(pic);
      [pic_usampled, ori_len] = undersample(pic,2);   % 2 times undersampling.  
      %intepo_pic = picinterpolated(pic_usampled, ori_len)
      intepo_pic = imresize(pic_usampled, 16);
      sixteenpic = imresize(pic, 16);
      imshow(sixteenpic);
      figure,imshow(pic_usampled);
      figure,imshow(intepo_pic);
      
function [pic_undersampled,ori_len] = undersample(pic1,a)

[x,y,z] = size(pic1);

if(x<=y)
    pic1 = pic1(1:x,1:x)
    ori_len = x;
else 
    pic1 = pic1(1:y,1:y)
    ori_len = y;
end 

if(z==1)
    pic_undersampled = pic1([1:a:x],[1:a:y]);
else
    pic_undersampled = pic1([1:a:x],[1:a:y],[1:1:z]);
end
end

function [intepo_pic] = picinterpolated(pic_usampled, ori_len)

[X,Y,z] = size(pic_usampled);
x_small = linspace(1, X, X);
y_small = linspace(1, Y, Y);
[Xsmall,Ysmall] = meshgrid(x_small,y_small);
x = linspace(1, X, ori_len);
y = linspace(1, Y, ori_len);
[Xbig,Ybig] = meshgrid(x,y);
intepo_pic = interp2(Xsmall, Ysmall, pic_usampled,Xbig,Ybig,'cubic');
end