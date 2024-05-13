function [ ] = ExtractDefDetectImgSoftSDMet3(pathImages, outputPath, imageNameP, fileVectorDef, spotSize)
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
% Extracts the defects of the oranges, generates as output a file with data 
% separated by commas and generates intermediate images with the defects in, 
% the fruit and the defects, the outline of the fruits.
%
% spotsize represents the size in pixels, it is used to eliminate
% small spots and leave an outline of the fruit. The ultimate goal is to get only the stains.
%
% Intermediate images are generated that correspond to:
% * previously generated image with background removed
% * intermediate image with fruits and defects
% * only isolated defects
%

% Extrae los defectos de las naranjas, genera como salida un archivo con
% datos separados por comas y genera imagenes intermedias con los defectos
% en, la fruta y los defectos, el contorno de las frutas.
%
% Usage:
% ExtractDefDetectImgSoftSDMet3(pathImages, pathAplicacion, imageNameP, candidateFile, sizeContours)
%
%

%% Configuration data files
outputPathBaRemoved=fullfile(outputPath,'removido'); % previously generated image with background removed
outputPathSiDefects=fullfile(outputPath,'sDefectos'); % intermediate image with fruits and defects
outputPathDefects=fullfile(outputPath,'defectos'); % only isolated defects
outputPathCDefects=fullfile(outputPath,'cDefectos');
outputPathOutlines=fullfile(outputPath,'contornos'); % fruit outlines

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

%% salida contornos
imageNameBinContour1=fullfile(outputPathOutlines,strcat(imageNameP,'_','CM1.jpg'));
imageNameBinContour2=fullfile(outputPathOutlines,strcat(imageNameP,'_','CM2.jpg'));
imageNameBinContour3=fullfile(outputPathOutlines,strcat(imageNameP,'_','CM3.jpg'));
imageNameBinContour4=fullfile(outputPathOutlines,strcat(imageNameP,'_','CM4.jpg'));
    
%% GRANULOMETRIES
%spotSize=1000; %1000 obtains contours
   
%% -- BEGIN DEFECTS FEATURES EXTRACTION ----------------------------------
%% Segmentacion de mascara para obtener defectos aislados de ROI
fprintf('Segmentacion de mascara para obtener REGIONES CANDIDATAS A DEFECTOS ROI --> \n');
SDMet3(imageNameRemoved1, imageNameOutput1);
SDMet3(imageNameRemoved2, imageNameOutput2);
SDMet3(imageNameRemoved3, imageNameOutput3);
SDMet3(imageNameRemoved4, imageNameOutput4);   
   
%% EXTRACCION pREWITT DE LOS BORDES DE LA NARANJA, VA CON segmentacion Prewitt
extractRegionDefPrewitt( imageNameOutput1, imageNameBinDefects1, imageNameBinContour1, spotSize);
extractRegionDefPrewitt( imageNameOutput2, imageNameBinDefects2, imageNameBinContour2, spotSize);
extractRegionDefPrewitt( imageNameOutput3, imageNameBinDefects3, imageNameBinContour3, spotSize);    
extractRegionDefPrewitt( imageNameOutput4, imageNameBinDefects4, imageNameBinContour4, spotSize);

%% Separación de defectos
fprintf('Separación REGIONES CANDIDATAS A DEFECTOS en color --> \n');
backgroundRemoval4(imageNameRemoved1, imageNameBinDefects1, imageNameColourDefectsC1);
backgroundRemoval4(imageNameRemoved2, imageNameBinDefects2, imageNameColourDefectsC2);
backgroundRemoval4(imageNameRemoved3, imageNameBinDefects3, imageNameColourDefectsC3);
backgroundRemoval4(imageNameRemoved4, imageNameBinDefects4, imageNameColourDefectsC4);

%% -- END DEFECTS FEATURES EXTRACTION ----------------------------------

end

