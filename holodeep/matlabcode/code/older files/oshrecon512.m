% OSH.m
% Adapted from "Contemporary Optical Image Processing with MATLAB,"
% by Ting-Chung Poon and Partha Banerjee, Table 7.2,
% Pages 222-223, Elsevier (2001).
%clear all,
%close all;
function [image0, imagen, imagep Phase] = oshrecon512()
%%Reading input bitmap files
lamda = 632e-9
%I=imread('pirate256.bmp','bmp');
[I0 Phase] = fresneldiffraction();
I0 = I0.*1;
Phase = Phase.*1;
pixelsize=3.8e-6; %(6e-6); % 2um pixel size
U0=sqrt(I0*1000).*exp(1i.*Phase);
dz=0.00001;   % defocus distance 10um
Uz  =  Numerical_Propagation(U0,dz,pixelsize,lamda,'Fresnel');
I=Uz.*conj(Uz);
U_z  = Numerical_Propagation(U0,-dz,pixelsize,lamda,'Fresnel');
I_z=Uz.*conj(Uz);

% figure
% colormap(gray(255));
% mesh(I);
% title('Mesh original image');
% axis off

%dIdz=(Iz-I_z)/2/dz; % axial intensity derivative

figure 
I=I(:,:,1);
figure(1)%displaying input
colormap(gray(255));
image(I)
title('Original image')
axis off
%pause
%%Creating OTFosh with SIGMA=z/2*k0 (Eq.(3.5-1a))
ROWS=256;
COLS=256;
sigma=2.0; %not necessary to scale
%kx,ky are spatial frequencies
z = 1;
ky=-12.8;
for r=1:COLS,
kx=-12.8;
for c=1:ROWS,
%OTFosh(r,c)=exp(-j*sigma*kx*kx-j*sigma*ky*ky);
OTFosh(r,c)=exp(1i*pi*lamda -z*(j*sigma*kx*kx-j*sigma*ky*ky));
kx=kx+.1;
end
ky=ky+.1;
end

z_r_n = 0.99;
z_r = 1;
z_r_p = 1.01;
ky=-12.8;
for r=1:COLS,
kx=-12.8;
for c=1:ROWS,
%OTFosh(r,c)=exp(-j*sigma*kx*kx-j*sigma*ky*ky);
OTFosh_recon_n(r,c)=exp(1i*pi*lamda -z_r_n*(j*sigma*kx*kx-j*sigma*ky*ky));
OTFosh_recon(r,c)=exp(1i*pi*lamda -z_r*(j*sigma*kx*kx-j*sigma*ky*ky));
OTFosh_recon_p(r,c)=exp(1i*pi*lamda -z_r_p*(j*sigma*kx*kx-j*sigma*ky*ky));
kx=kx+.1;
end
ky=ky+.1;
end

max1=max(OTFosh);
max2=max(max1);
scale=1.0/max2;
OTFosh=OTFosh.*scale;
%Recording hologram
% Taking Fourier transform of I
FI=fft2(I);
FI=fftshift(FI);
max1=max(FI);
max2=max(max1);
scale=1.0/max2;
FI=FI.*scale;
% FH is the recorded hologram in Fourier domain
FH=FI.*OTFosh;
H=ifft2(FH);
max1=max(H);
max2=max(max1);
scale=1.0/max2;


H=H.*scale;


figure
colormap(gray(255));
%Displaying the real part becomes sine-FZP hologram
% Eq. (3.5-8a)
image(2.5*real(256*H));
title('Sine-FZP hologram')
axis off
figure
colormap(gray(255));
%Displaying the imaginary part becomes cosine-FZP hologram
% Eq. (3.5-8b)
image(2.5*imag(256*H));
title('Cosine-FZP hologram')
axis off
%Reconstructing holograms
%Reconstruction of sine-hologram,twin-image noise exists
figure
colormap(gray(255))
H=ifft2(FH);
FRSINEH=fft2(real(H)).*conj(OTFosh); %Eq. (2.5-10)
RSINEH=ifft2(FRSINEH);
image(256*abs(RSINEH)/max(max(abs(RSINEH))))
title('Reconstruction of sine-FZP hologram')
axis off
%FH=FHI;
%Reconstruction with cosine-hologram, twin-image noise exists
figure
colormap(gray(255))
FRCOSINEH=fft2(imag(H)).*conj(OTFosh);
RCOSINEH=ifft2(FRCOSINEH); %Eq. (3.5-10)
image(256*abs(RCOSINEH)/max(max(abs(RCOSINEH))))
title('Reconstruction of cosine-FZP hologram')
axis off

% figure(5)
% colormap(gray(255))
FRCOMPLEXH=fft2(real(H)+j*imag(H)).*conj(OTFosh_recon_n);
RCOMPLEX=ifft2(FRCOMPLEXH);
imagen = 1.4*256*abs(RCOMPLEX)/max(max(abs(RCOMPLEX)));
% image(imagen)
% title('Negative Real image reconstruction of complex FZP hologram,Hc+')
% axis off

figure
colormap(gray(255))
FRCOMPLEXH=fft2(real(H)+j*imag(H)).*conj(OTFosh_recon);
RCOMPLEX=ifft2(FRCOMPLEXH);
image0 = 1.4*256*abs(RCOMPLEX)/max(max(abs(RCOMPLEX)));
image(image0)
title('Real image reconstruction of complex FZP hologram,Hc+')
axis off

% figure(6)
% colormap(gray(255));
% mesh(image0);
% title('XXX');
% axis off

figure
colormap(gray(255))
FRCOMPLEXH=fft2(real(H)+j*imag(H)).*conj(OTFosh_recon_p);
RCOMPLEX=ifft2(FRCOMPLEXH);
imagep = 1.4*256*abs(RCOMPLEX)/max(max(abs(RCOMPLEX)));
image(imagep)
title('Postive Real image reconstruction of complex FZP hologram,Hc+')
axis off

% figure(8)
% colormap(gray(255));
% mesh(image0-imagep);
% title('XXX');
% axis off

% 
% scale = 255/min(min(imagep-imagen));
% 
% dIdz=(imagep-imagen)/2/min(min(imagep-imagen))*scale;
% 
% figure(8)
% colormap(gray(255))
% image(dIdz)
% title('Difference of Real image reconstruction of complex FZP hologram,Hc+')
% axis off

figure
colormap(gray(255))
FRCOMPLEXH2=fft2(real(H)-j*imag(H)).*conj(OTFosh);
RCOMPLEX2=ifft2(FRCOMPLEXH2);
image(1.4*256*abs(RCOMPLEX2)/max(max(abs(RCOMPLEX2))))
title('Reconstruction of complex FZP hologram, Hc-')
axis off
end

