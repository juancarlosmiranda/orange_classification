function [ meanH, meanS, meanV, stdDevH, stdDevS, stdDevV ] = extractMeanCImgHSV( IRGBCropped, IMaskC)
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
% This function calculates the average colour of an image, using a mask to 
% quantify the colour and values that are extracted.
% The result is obtained converting images to the HSV color space.
%

% Usage:
% [ meanH, meanS, meanV, stdDevH, stdDevS, stdDevV ] = extractMeanCImgHSV(
% IRGBCropped, IMaskC);
%
% Foreground values are 1, background values are 0
FOREGROUND=1;

% Reading background image
IHSVCropped=rgb2hsv(IRGBCropped); % HSV colour space
IMask=IMaskC;

[rowSize, colSize, ~]=size(IRGBCropped);

sumH=double(0.0);
sumS=double(0.0);
sumV=double(0.0);
pixelCounter=double(0.0);

% variables for calculating variance
varianceSumH=double(0.0);
varianceSumS=double(0.0);
varianceSumV=double(0.0);

% iterating over the mask
for f=1:1:rowSize
    for c=1:1:colSize
        % Read from the mask image if the value is different from zero
        pixelMask=IMask(f,c);
        if pixelMask == FOREGROUND
            sumH=double(IHSVCropped(f,c,1))+sumH;
            sumS=double(IHSVCropped(f,c,2))+sumS;
            sumV=double(IHSVCropped(f,c,3))+sumV; 
            pixelCounter=pixelCounter+1;
        end
    end
end

% --------------------------------------
% mean values calculated by channels
%---------------------------------------
meanH=double(sumH/pixelCounter); % mean H channel
meanS=double(sumS/pixelCounter); % mean S channel
meanV=double(sumV/pixelCounter); % mean V channel

%------------------------------------------------------------------------
% sample variance
%------------------------------------------------------------------------
for f=1:1:rowSize
    for c=1:1:colSize
        % Read from the mask image, and checking if the value is different from zero.
        pixelMask=IMask(f,c);
        if pixelMask == FOREGROUND            
            varianceSumH=varianceSumH+(IHSVCropped(f,c,1)-meanH)^2;
            varianceSumS=varianceSumS+(IHSVCropped(f,c,2)-meanS)^2;
            varianceSumV=varianceSumV+(IHSVCropped(f,c,3)-meanV)^2;            
        end
    end
end
% -----------------------------------------------------------------------
stdDevH=sqrt(varianceSumH/(pixelCounter));
stdDevS=sqrt(varianceSumS/(pixelCounter));
stdDevV=sqrt(varianceSumV/(pixelCounter));

end
