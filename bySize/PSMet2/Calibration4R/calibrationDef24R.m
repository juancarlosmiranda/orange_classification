function [output_args]=calibrationDef24R(pathCalibracion, nombreImagenP,archivoCalibracion)
%% calibracion de valores
%clc; clear all; close all;

diametermm=0.0;
calibrationAreamm=0.0;


%% caracteristicas geometricas
% rectangle 1
areaPxR1=0;
diameterPxR1=0;
majorAxisPxR1=0;
minorAxisPxR1=0;
equivalence1mmSquaredR1=0.0;
equivalence1mmR1=0.0;

% rectangle 2
areaPxR2=0;
diameterPxR2=0;
majorAxisPxR2=0;
minorAxisPxR2=0;
equivalence1mmSquaredR2=0.0;
equivalence1mmR2=0.0;

% rectangle 3
areaPxR3=0;
diameterPxR3=0;
majorAxisPxR3=0;
minorAxisPxR3=0;
equivalence1mmSquaredR3=0.0;
equivalence1mmR3=0.0;

% rectangle 4
areaPxR4=0;
diameterPxR4=0;
majorAxisPxR4=0;
minorAxisPxR4=0;
equivalence1mmSquaredR4=0.0;
equivalence1mmR4=0.0;

objecSize=500;

imageNameSilhouetteN1=fullfile(pathCalibracion,strcat(nombreImagenP,'_','sN1.jpg'));
imageNameSilhouetteN2=fullfile(pathCalibracion,strcat(nombreImagenP,'_','sN2.jpg'));
imageNameSilhouetteN3=fullfile(pathCalibracion,strcat(nombreImagenP,'_','sN3.jpg'));
imageNameSilhouetteN4=fullfile(pathCalibracion,strcat(nombreImagenP,'_','sN4.jpg'));

fprintf('------------------------------------------------- \n');
fprintf('Enter values ​​for measurement conversion \n');
fprintf('------------------------------------------------- \n');

fprintf('Calibration is performed based on a known sphere \n');

fprintf('Calculating geometric features from an image \n');
[areaPxR1, diameterPxR1, majorAxisPxR1, minorAxisPxR1]=extractGeoFeatures4R(imageNameSilhouetteN1,objecSize);
[areaPxR2, diameterPxR2, majorAxisPxR2, minorAxisPxR2]=extractGeoFeatures4R(imageNameSilhouetteN2,objecSize);
[areaPxR3, diameterPxR3, majorAxisPxR3, minorAxisPxR3]=extractGeoFeatures4R(imageNameSilhouetteN3,objecSize);
[areaPxR4, diameterPxR4, majorAxisPxR4, minorAxisPxR4]=extractGeoFeatures4R(imageNameSilhouetteN4,objecSize);


diametermm=input('Enter DIAMETER of the calibration sphere in millimeters: ');
calibrationAreamm=pi*((diametermm^2)/4); % real area of ​​the calibration sphere

%% Calculation of conversion coefficients according to cuts
equivalence1mmSquaredR1=calibrationAreamm/areaPxR1;
equivalence1mmR1=sqrt(equivalence1mmSquaredR1);

equivalence1mmSquaredR2=calibrationAreamm/areaPxR2;
equivalence1mmR2=sqrt(equivalence1mmSquaredR2);

equivalence1mmSquaredR3=calibrationAreamm/areaPxR3;
equivalence1mmR3=sqrt(equivalence1mmSquaredR3);

equivalence1mmSquaredR4=calibrationAreamm/areaPxR4;
equivalence1mmR4=sqrt(equivalence1mmSquaredR4);

%% Printing summary report
fprintf('---------\n');
fprintf('Summary report \n');
fprintf('---------\n');
fprintf('\n -------------------------------- \n');
fprintf('Area de Calibración= %f \n', calibrationAreamm);
fprintf('Area en pixeles R1 = %f \n', areaPxR1);
fprintf('1 pixel^2 R1= %f mm^2\n', equivalence1mmSquaredR1);
fprintf('1 pixel lineal R1= %f mm\n', equivalence1mmR1);
fprintf('\n -------------------------------- \n');

%% impresion de archivo
fileHeader=sprintf('<productinfo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.mathworks.com/namespace/info/v1/info.xsd">\n');
stringDiameter=sprintf('<listitem>\n <label>diametroEsfera</label>\n <value>%f</value>\n </listitem>\n',diametermm);
stringCalibrationArea=sprintf('<listitem>\n <label>areaCalibracion</label>\n <value>%f</value>\n </listitem>\n',calibrationAreamm);
stringPixelAreaR1=sprintf('<listitem>\n <label>areaPixelesR1</label>\n <value>%f</value>\n </listitem>\n',areaPxR1);
stringPixelAreaR2=sprintf('<listitem>\n <label>areaPixelesR2</label>\n <value>%f</value>\n </listitem>\n',areaPxR2);
stringPixelAreaR3=sprintf('<listitem>\n <label>areaPixelesR3</label>\n <value>%f</value>\n </listitem>\n',areaPxR3);
stringPixelAreaR4=sprintf('<listitem>\n <label>areaPixelesR4</label>\n <value>%f</value>\n </listitem>\n',areaPxR4);
stringSquaredPixelR1=sprintf('<listitem>\n <label>pixelCuadradoR1</label>\n <value>%f</value>\n </listitem>\n', equivalence1mmSquaredR1);	
stringSquaredPixelR2=sprintf('<listitem>\n <label>pixelCuadradoR2</label>\n <value>%f</value>\n </listitem>\n', equivalence1mmSquaredR2);
stringSquaredPixelR3=sprintf('<listitem>\n <label>pixelCuadradoR3</label>\n <value>%f</value>\n </listitem>\n', equivalence1mmSquaredR3);
stringSquaredPixelR4=sprintf('<listitem>\n <label>pixelCuadradoR4</label>\n <value>%f</value>\n </listitem>\n', equivalence1mmSquaredR4);	
stringLinearPixellR1=sprintf('<listitem>\n <label>pixelLinealR1</label>\n <value>%f</value>\n </listitem> \n',equivalence1mmR1);
stringLinearPixelR2=sprintf('<listitem>\n <label>pixelLinealR2</label>\n <value>%f</value>\n </listitem> \n',equivalence1mmR2);
stringLinearPixelR3=sprintf('<listitem>\n <label>pixelLinealR3</label>\n <value>%f</value>\n </listitem> \n',equivalence1mmR3);
stringLinearPixelR4=sprintf('<listitem>\n <label>pixelLinealR4</label>\n <value>%f</value>\n </listitem> \n',equivalence1mmR4);
fileEnd=sprintf('</productinfo>')

fprintf('\n <!-- ---------- CUT UP TO HERE ------ --> \n');
fprintf('%s',stringDiameter);
fprintf('%s',stringCalibrationArea);
fprintf('%s',stringPixelAreaR1);
fprintf('%s',stringPixelAreaR2);
fprintf('%s',stringPixelAreaR3);
fprintf('%s',stringPixelAreaR4);
fprintf('%s',stringSquaredPixelR1);
fprintf('%s',stringSquaredPixelR2);
fprintf('%s',stringSquaredPixelR3);
fprintf('%s',stringSquaredPixelR4);
fprintf('%s',stringLinearPixellR1);
fprintf('%s',stringLinearPixelR2);
fprintf('%s',stringLinearPixelR3);
fprintf('%s',stringLinearPixelR4);
fprintf('\n <!-- ---------- CUT UP TO HERE ------ --> \n');

fileID = fopen(archivoCalibracion,'w');
fprintf(fileID,fileHeader);
fprintf(fileID,'%s',stringDiameter);
fprintf(fileID,'%s',stringCalibrationArea);
fprintf(fileID,'%s',stringPixelAreaR1);
fprintf(fileID,'%s',stringPixelAreaR2);
fprintf(fileID,'%s',stringPixelAreaR3);
fprintf(fileID,'%s',stringPixelAreaR4);
fprintf(fileID,'%s',stringSquaredPixelR1);
fprintf(fileID,'%s',stringSquaredPixelR2);
fprintf(fileID,'%s',stringSquaredPixelR3);
fprintf(fileID,'%s',stringSquaredPixelR4);
fprintf(fileID,'%s',stringLinearPixellR1);
fprintf(fileID,'%s',stringLinearPixelR2);
fprintf(fileID,'%s',stringLinearPixelR3);
fprintf(fileID,'%s',stringLinearPixelR4);
fprintf(fileID,fileEnd);

end
