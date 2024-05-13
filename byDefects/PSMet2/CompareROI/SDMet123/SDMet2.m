function [ ] = SDMet2(imageNameToSegment, imageNameOutput)
% ########################################################################
% Project AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING 
% COMPUTER VISION TECHNIQUES 2018
% juancarlosmiranda81@gmail.com
% ########################################################################
IOrig=imread(imageNameToSegment);
IGray=rgb2gray(IOrig);

%% filtered to soften the image
h1=fspecial('average',[3,3]); % the mean filter influences, previously [5,5]
media1=imfilter(IGray,h1);

%% get gradients, gradients indicate where the colors change
[Gmag, ~] = imgradient(media1,'Prewitt');
I = mat2gray(Gmag);

nivel=0.10; % threshold placed based on experience
IB2=im2bw(I,nivel);

% aperture to eliminate small details
SE = strel('disk', 1);
IB3 = imopen(IB2,SE);

%% Store cluster images in files
imwrite(IB3,imageNameOutput,'jpg');
end

