function [ ] = ExtractDefDetectImgSoft2(pathImages, outputPath, imageNameP, fileVectorDef, spotSize, trainedClassifierObj)
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
%
%
% Extracts the defects of the oranges, generates as output a file with
% data separated by commas and generates intermediate images with the defects
% in, the fruit and defects, the outline of the fruits.
%
% spotsize represents the size in pixels, it is used to eliminate
% small spots and leave an outline of the fruit. The ultimate goal is
% get only the stains.
%
%
% -----------------------------------------------------------------------

%% Configuration data files
initialImage=strcat(pathImages,imageNameP); % for writing to results file

outputPathBaRemoved=fullfile(outputPath,'removido'); % previously generated image with background removed
outputPathSiDefects=fullfile(outputPath,'sDefectos'); % intermediate image with fruits and defects
outputPathDefects=fullfile(outputPath,'defectos'); % only isolated defects
outputPathCDefects=fullfile(outputPath,'cDefectos');
outputPathOutlines=fullfile(outputPath,'contornos'); % fruit outlines
outputPathDetection=fullfile(outputPath,'deteccion');

% file names with removed objects
imageNameRemoved1=fullfile(outputPathBaRemoved,strcat(imageNameP,'_','rm1.jpg'));
imageNameRemoved2=fullfile(outputPathBaRemoved,strcat(imageNameP,'_','rm2.jpg'));
imageNameRemoved3=fullfile(outputPathBaRemoved,strcat(imageNameP,'_','rm3.jpg'));
imageNameRemoved4=fullfile(outputPathBaRemoved,strcat(imageNameP,'_','rm4.jpg'));

%% segmentation output
imageNameOutput1=fullfile(outputPathSiDefects,strcat(imageNameP,'_','so1.jpg'));
imageNameOutput2=fullfile(outputPathSiDefects,strcat(imageNameP,'_','so2.jpg'));
imageNameOutput3=fullfile(outputPathSiDefects,strcat(imageNameP,'_','so3.jpg'));
imageNameOutput4=fullfile(outputPathSiDefects,strcat(imageNameP,'_','so4.jpg'));

%% output defects
imageNameBinDefects1=fullfile(outputPathDefects,strcat(imageNameP,'_','soM1.jpg'));
imageNameBinDefects2=fullfile(outputPathDefects,strcat(imageNameP,'_','soM2.jpg'));
imageNameBinDefects3=fullfile(outputPathDefects,strcat(imageNameP,'_','soM3.jpg'));
imageNameBinDefects4=fullfile(outputPathDefects,strcat(imageNameP,'_','soM4.jpg'));

%% output defects in COLOR
imageNameColourDefectsC1=fullfile(outputPathCDefects,strcat(imageNameP,'_','soC1.jpg'));
imageNameColourDefectsC2=fullfile(outputPathCDefects,strcat(imageNameP,'_','soC2.jpg'));
imageNameColourDefectsC3=fullfile(outputPathCDefects,strcat(imageNameP,'_','soC3.jpg'));
imageNameColourDefectsC4=fullfile(outputPathCDefects,strcat(imageNameP,'_','soC4.jpg'));
    
%% contour output
imageNameBinContour1=fullfile(outputPathOutlines,strcat(imageNameP,'_','CM1.jpg'));
imageNameBinContour2=fullfile(outputPathOutlines,strcat(imageNameP,'_','CM2.jpg'));
imageNameBinContour3=fullfile(outputPathOutlines,strcat(imageNameP,'_','CM3.jpg'));
imageNameBinContour4=fullfile(outputPathOutlines,strcat(imageNameP,'_','CM4.jpg'));

imageNameColourDetection1=fullfile(outputPathDetection,strcat(imageNameP,'_','DET1.jpg'));
imageNameColourDetection2=fullfile(outputPathDetection,strcat(imageNameP,'_','DET2.jpg'));
imageNameColourDetection3=fullfile(outputPathDetection,strcat(imageNameP,'_','DET3.jpg'));
imageNameColourDetection4=fullfile(outputPathDetection,strcat(imageNameP,'_','DET4.jpg'));
    
%% GRANULOMETRIES
%spotSize=1000; %1000 obtains contours
   
%% -- BEGIN DEFECTS FEATURES EXTRACTION ----------------------------------
%% Mask segmentation to obtain isolated defects from ROI
fprintf('Mask segmentation to obtain CANDIDATE REGIONS FOR ROI DEFECTS --> \n');
SDMet2(imageNameRemoved1, imageNameOutput1);
SDMet2(imageNameRemoved2, imageNameOutput2);
SDMet2(imageNameRemoved3, imageNameOutput3);
SDMet2(imageNameRemoved4, imageNameOutput4);   

   
%% Prewitt extraction of the edges of the orange, goes with Prewitt segmentation
extractRegionDefPrewitt( imageNameOutput1, imageNameBinDefects1, imageNameBinContour1, spotSize);
extractRegionDefPrewitt( imageNameOutput2, imageNameBinDefects2, imageNameBinContour2, spotSize);
extractRegionDefPrewitt( imageNameOutput3, imageNameBinDefects3, imageNameBinContour3, spotSize);    
extractRegionDefPrewitt( imageNameOutput4, imageNameBinDefects4, imageNameBinContour4, spotSize);
   
%% Defect separation
fprintf('Separation of candidate regions for color defects --> \n');
backgroundRemoval4(imageNameRemoved1, imageNameBinDefects1, imageNameColourDefectsC1);
backgroundRemoval4(imageNameRemoved2, imageNameBinDefects2, imageNameColourDefectsC2);
backgroundRemoval4(imageNameRemoved3, imageNameBinDefects3, imageNameColourDefectsC3);
backgroundRemoval4(imageNameRemoved4, imageNameBinDefects4, imageNameColourDefectsC4);

%% -- END DEFECTS FEATURES EXTRACTION ----------------------------------

%% CLASSIFY CANDIDATIVE DEFECTS
% For each image of R1..R4 the defects are taken and counted. These defects are taken to a classifier that counts the possible defects found by region.
%archivoVectorDef='';
fprintf('Detection of CANDIDATE REGIONS FOR DEFECTS in color --> \n');
detectROICandidates3( outputPath, 1, imageNameRemoved1 ,imageNameBinDefects1, imageNameColourDefectsC1, imageNameColourDetection1,fileVectorDef, imageNameP, trainedClassifierObj);
detectROICandidates3( outputPath, 2, imageNameRemoved2 ,imageNameBinDefects2, imageNameColourDefectsC2, imageNameColourDetection2,fileVectorDef, imageNameP, trainedClassifierObj);
detectROICandidates3( outputPath, 3, imageNameRemoved3 ,imageNameBinDefects3, imageNameColourDefectsC3, imageNameColourDetection3,fileVectorDef, imageNameP, trainedClassifierObj);
detectROICandidates3( outputPath, 4, imageNameRemoved4 ,imageNameBinDefects4, imageNameColourDefectsC4, imageNameColourDetection4,fileVectorDef, imageNameP,trainedClassifierObj);
% -----------------------------------------------------------------------
end
