function [ ] = ProcessCalibrationImg(pathImages, outputPath, imageNameP, rectangleList, objectAreaBR, LchannelMin, LchannelMax, AchannelMin, AchannelMax, BchannelMin, BchannelMax)
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
% Separates the background and generates images with the regions of interest
% separated.
% An image is processed to obtain binary masks. With these masks the 
% equivalence of pixels to millimeters is calculated.
%
% Usage:
%
% ProcessCalibrationImg(pathImagesCalibration, pathCalibration, imageNameP, rectangleList, objectAreaBR, LchannelMin, LchannelMax, AchannelMin, AchannelMax, BchannelMin, BchannelMax);
%
% -----------------------------------------------------------------------


initialImage=fullfile(pathImages,imageNameP);

%% Setting up the directory folder structure
outputPathPR=fullfile(outputPath,'pr'); % pre procesing
outputPathBR=fullfile(outputPath,'br'); % background removal
outputPathROI=fullfile(outputPath,'roi'); % region of interest
outputPathSiFruits=fullfile(outputPath,'sFrutas');
outputPathBaRemoved=fullfile(outputPath,'removido');

% --- NAME OF INTERMEDIATE IMAGES ---
% with background removed
imageNamePR=fullfile(outputPathPR,strcat(imageNameP,'_','PR.jpg'));
imageNameBR=fullfile(outputPathBR,strcat(imageNameP,'_','BR.jpg'));
imageNameROI=fullfile(outputPathROI,strcat(imageNameP,'_','RO.jpg'));
imageNameF=fullfile(outputPathROI,strcat(imageNameP,'_','I.jpg'));

% prefix for images of removed background and silhouettes of removed backgrounds in object detection
imageNameSilhouettesN=fullfile(outputPathSiFruits,strcat(imageNameP,'_','sN'));
imageNameRemoved=fullfile(outputPathBaRemoved,strcat(imageNameP,'_','rm'));


%% -- BEGIN IMAGE PROCESSING ----------------------------------
%[X,Y,W,H] top-left corner X,Y; W=horizontal width, H= vertical height
% * ---------> X
% |  (x,y)-----|
% |  |         |
% |  |------ W,H
% |
% Y
% V
% It follows this sintax xmin,ymin,width,height
rectangle1_X=rectangleList(1,1);
rectangle1_Y=rectangleList(1,2);
rectangle1_W=rectangleList(1,3);
rectangle1_H=rectangleList(1,4);

fprintf('BR -> Background segmentation --> \n'); % output an image with 4 silhouettes
BRemovalLAB(initialImage, imageNameBR, imageNameF, objectAreaBR, LchannelMin, LchannelMax, AchannelMin, AchannelMax, BchannelMin, BchannelMax,rectangle1_X, rectangle1_Y-2, rectangle1_W, rectangle1_H);

%% Removing background
fprintf('BR -> Removing background, separating Region of Interest (ROI) --> \n'); % output an image with 4 objects
backgroundRemoval4(initialImage, imageNameBR, imageNameROI);

%% Working with cropped ROIs
fprintf('BR -> Detection of objects in frames. Cropping ROI and ROI silhouettes --> \n'); % output 4 images of an object each assigns numbers of objects according to membership in the box
objectDetection2(imageNameBR, imageNameROI, imageNameSilhouettesN, imageNameRemoved, rectangleList );

end

