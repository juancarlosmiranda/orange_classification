function [ ] = extractRegionDefPrewitt( imageNameSpots, imageNameDefects, imageNameContour, maximumSpotSize )
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
% Receives segmented images, counts them and generates a defect image
% Produces a final image with spots and no outline.
%
% Usage:

%% Reading images
ISpots=imread(imageNameSpots);

%% Binarización
threshold=graythresh(ISpots);
ISpotsB1=im2bw(ISpots,threshold); % binarized
ISpotContour=im2bw(ISpots,threshold); % It is used to obtain the complement, the particles are deleted

%% Label connected elements
[objectList Ne]=bwlabel(ISpotContour);

%% Calculate properties of image objects
objectProperties= regionprops(objectList);

%% Search for areas smaller than maxSpotSize
seleccion=find([objectProperties.Area]<maximumSpotSize);

%% To clean areas
for n=1:size(seleccion,2)
    coordinatesToPaint=round(objectProperties(seleccion(n)).BoundingBox);
    % painted spots in black
    ISpotContour(coordinatesToPaint(2):coordinatesToPaint(2)+coordinatesToPaint(4)-1,coordinatesToPaint(1):coordinatesToPaint(1)+coordinatesToPaint(3)-1)=0;
end

%% remove the contour and leave only defects
ISpotsB2=bitxor(ISpotsB1,ISpotContour);

%% exaggerate defects so that they can be painted well
% Lock application to enlarge and close holes, this allows have better 
% silhouettes of defects. Use an element major structuring

SE = strel('disk', 1); %1 FUNCIONA MUY BIEN 2 es bueno
ISpotsB3 = imclose(ISpotsB2,SE); % exaggerating the mask allows me to take more region of the defect

%% closes spots with holes
IManchasFinal = imfill(ISpotsB3,'holes');

%% ----------------------------------
%% saved images and outlines
imwrite(ISpotContour,imageNameContour,'jpg')
imwrite(IManchasFinal,imageNameDefects,'jpg')
end
