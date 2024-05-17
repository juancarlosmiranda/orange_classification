function [sumOfArea] = pixelCount( imageNameSilhouette)
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
%
%

%% Image reading
IOrig=imread(imageNameSilhouette);

%% Thresholding and Binarization
umbral=graythresh(IOrig);
IB1=im2bw(IOrig,umbral);

%% Labeling of connected areas, binary image required
[L Ne]=bwlabel(IB1); % in L the objects and in Ne= numbers of labeled areas

%% Calculation of properties of image objects
% the necessary geometric data are taken to later characterize them.
objectProperties= regionprops(L,'Area');

%% Show geometric features
% The obtained properties are traversed from beginning to end
sumOfArea=0;
for n=1:size(objectProperties,1)
    sumOfArea=sumOfArea+objectProperties(n).Area;
end

end

