function [I Phase] = fresneldiffraction(N,filename)
I=zeros(N);
Phase=zeros(N);
% Ncenter  = 0;
% scale = 1;
% scale = 5e-1;
%Phase = im2double(rgb2gray(imread(filename)));
% I = im2double(rgb2gray(imread(filename)));

I = (imread(filename));

I = imresize(I, [N N]);
%I=I(:,:,1);



% figure 
% colormap(gray(255));
% image(I)
% title('Original image')
% axis off

% for ii=1:N
%      for jj=1:N    
%           x=(ii-Ncenter)*scale;%*(pixelsize);
%           y=(jj-Ncenter)*scale;%*(pixelsize);     
%           %Phase(ii,jj)=1.5-(x.^2-(y).^2-x*y);
%           %Phase(ii,jj)=1;
%           %Phase(ii,jj) = 1/(2*pi)*exp((-x.^2-y.^2)/(2*1e-5));
%           Phase(ii,jj)=5+ sin(2*pi*12*x.^2+y.^2);  %Try Sin function but
%           %does not work well   
%      end
% end

% for ii=1:N
%      for jj=1:N    
%           x=(ii-1)*scale;%*(pixelsize);
%           y=(jj-1)*scale;%*(pixelsize);   
%           sigma=1;
%           %Intensity(ii,jj)=10+ cos(2*pi*12*x.^2+y.^2); %Try Sin function but
%           %does not work well
%           %Intensity(ii,jj)=exp((-x.^2-y.^2)/(2*sigma.^2)); %/(2*sigma.^2));
%           Intensity(ii,jj)=2*sigma.^2;           
%      end
% end
% 
% I=zeros(N);
% 
% for ii=1:N
%      for jj=1:N
%          I(ii,jj)=Intensity(ii,jj);
%      end
% end

