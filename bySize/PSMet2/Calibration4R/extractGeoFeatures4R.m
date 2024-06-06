function [ sumAreapx, diameterPx, majorAxisPx, minorAxisPx ] = extractGeoFeatures4R( imageNameBinaryMask, objectSize)
%
% Project: AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING
% COMPUTER VISION TECHNIQUES
%
% Author: Juan Carlos Miranda. https://github.com/juancarlosmiranda/
% Date: 2018
% Update:  December 2023
%
% Description:
%
% Extract pixel-based geometric features from the
% silhouette.
%
% Extraer caracteristicas geometricas basadas en pixeles a partir de la
% silueta.

%
% Usage:
% [areaPxR1, diameterPxR1, majorAxisPxR1, minorAxisPxR1]=extractGeoFeatures4R(imageNameSilhouetteN1,objecSize);
%
%

%% Image reading
IOrig=imread(imageNameBinaryMask);

%% Thresholding and Binarization
umbral=graythresh(IOrig);
IB1=im2bw(IOrig,umbral);

%% Labeling of connected areas, binary image required
[L Ne]=bwlabel(IB1); %en L los objetos y en Ne= números de áreas etiquetadas

%% Calculation of properties of image objects
% the necessary geometric data are taken to later characterize them.
objProperties= regionprops(L,'Area','MajorAxisLength','MinorAxisLength');

%% Show geometric features
% The obtained properties are traversed from beginning to end
sumAreapx=0.0;
diameterPx=0;

majorAxisPx=0;
minorAxisPx=0;

for n=1:size(objProperties,1)
    if(objProperties(n).Area > objectSize)
        %fprintf('%s %10.2f; %10.2f \n', imageNameBinaryMask, n,objProperties(n).Area, objProperties(n).MajorAxisLength);
        sumAreapx=sumAreapx+objProperties(n).Area;
        majorAxisPx=objProperties(n).MajorAxisLength;
        minorAxisPx=objProperties(n).MinorAxisLength;
    end
end
% calculation of diameterPx by circumference
diameterPx=sqrt((sumAreapx*4)/pi);

end

