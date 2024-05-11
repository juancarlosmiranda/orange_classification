function [ sumArea, perimeter, excentricity, majorAxis, minorAxis ] = extractDefCarGeoImg(IOrig)
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
%
% Usage:
% Extract geometric data from binary images.
% 
% Usage:
%
%% Reading image
%IOrig=imread(imagenNombreSilueta);
%% Thresholding and Binarization
%threshold=graythresh(IOrig);
%IB1=im2bw(IOrig,umbral);
IB1=IOrig;

%% Labeling of connected areas, a binary image is needed
[L Ne]=bwlabel(IB1); % in L the objects and in Ne= numbers of labeled areas

%% Calculation of properties of image objects
% the necessary geometric data are taken to later characterize them.
objProperties= regionprops(L,'Area','Perimeter','Eccentricity','MajorAxisLength','MinorAxisLength');

%% Show geometric features
% The properties obtained are reviewed from beginning to end.
sumArea=0;
perimeter=0;
excentricity=0;
majorAxis=0;
minorAxis=0;

for n=1:size(objProperties,1)
%    if(propiedades(n).Area > tamano)
%        fprintf('%10i; %10.4f; %10.4f; %10.4f; %10.4f; \n', propiedades(n).Area, propiedades(n).Perimeter, propiedades(n).Eccentricity, propiedades(n).MajorAxisLength, propiedades(n).MinorAxisLength);
         sumArea=objProperties(n).Area;
         perimeter=objProperties(n).Perimeter;
         excentricity=objProperties(n).Eccentricity;
         majorAxis=objProperties(n).MajorAxisLength;
         minorAxis=objProperties(n).MinorAxisLength; 
%    end
end


end
