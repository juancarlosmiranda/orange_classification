function [ ] = ProcessImgSoft(pathImages, outputPath, imageNameP, rectsangleList, objectAreaBR, LchannelMin, LchannelMax, AchannelMin, AchannelMax, BchannelMin, BchannelMax )
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
% For each image, the background is separated, segmenting the four images
% according to tables defined in a previous configuration.
% Background is removed using channels in LAB space.
% INTERMEDIATE IMAGES ARE GENERATED:
% * SILHOUETTES WITH FOUR FRUITS, REGION OF INTEREST WITH FOUR FRUITS
% * BACKGROUND REMOVED.
% * SILHOUETTES CORRESPONDING TO THE REMOVED BACKGROUND
% geometric characteristics.
%
% Usage:
% MainDefDetectONLINE4R.m
%
% ProcessImgSoft(pathImagesTest, outputPath, imageNameP, rectangleList, objectAreaBR, LchannelMin, LchannelMax, AchannelMin, AchannelMax, BchannelMin, BchannelMax )
%
% -----------------------------------------------------------------------

%% Configuration data files
initialImage=fullfile(pathImages,imageNameP);


%% SAVE DIRECTORIES
outputPathBR=fullfile(outputPath,'br'); % background removal
outputPathROI=fullfile(outputPath,'roi'); % region of interest

outputPathSiFruits=fullfile(outputPath,'sFrutas'); % fruit silhouettes
outputPathBaRemoved=fullfile(outputPath,'removido'); % images background removed

% --- NAME OF INTERMEDIATE IMAGES ---
% with background removed
imageNameBR=fullfile(outputPathBR,strcat(imageNameP,'_','BR.jpg')); % to indicate silhouette of the removed background
imageNameROI=fullfile(outputPathROI,strcat(imageNameP,'_','RO.jpg')); % to indicate fund removed and ROI
imageNameF=fullfile(outputPathROI,strcat(imageNameP,'_','I.jpg')); % prior to inverse

% prefix for images of removed background and silhouettes of removed backgrounds in object detection
imageNameSilhouettesN=fullfile(outputPathSiFruits,strcat(imageNameP,'_','sN'));
imageNameRemoved=fullfile(outputPathBaRemoved,strcat(imageNameP,'_','rm'));



%% -- BEGIN IMAGE PROCESSING ----------------------------------
%% ----- BEGIN defining edges
% For definition of rectangles PREVIOUSLY CONFIGURED TO DETECT THE IMAGE NUMBER FROM A GENERAL IMAGE WITH MIRRORS
rectangle1_Y=rectsangleList(1,1);
rectangle1_X=rectsangleList(1,2);
rectangle1_H=rectsangleList(1,3);
rectangle1_W=rectsangleList(1,4);

fprintf('BR -> Background segmentation --> \n'); % output an image with 4 silhouettes
BRemovalLAB(initialImage, imageNameBR, imageNameF, objectAreaBR, LchannelMin, LchannelMax, AchannelMin, AchannelMax, BchannelMin, BchannelMax,rectangle1_Y, rectangle1_X-2, rectangle1_H, rectangle1_W);

%% Removing background
fprintf('BR -> Removing background, separating Region of Interest (ROI) --> \n'); % output an image with 4 objects
backgroundRemoval4(initialImage, imageNameBR, imageNameROI);

%% Working with cropped ROIs
fprintf('BR -> Detection of objects in frames. Cropping ROI and ROI silhouettes --> \n'); % output 4 images of an object each assigns numbers of objects according to membership in the box
objectDetection2( imageNameBR, imageNameROI, imageNameSilhouettesN, imageNameRemoved, rectsangleList ); 

%% -- END IMAGE PROCESSING ----------------------------------

end

