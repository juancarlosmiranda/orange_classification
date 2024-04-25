function [ meanL, meanA, meanB, stdL, stdA, stdB ] = extractMeanCImgLAB( IRGBCropped, IMaskC)
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
% The result is obtained converting images to the LAB color space.
%

% Usage:
% [ meanL, meanA, meanB, stdL, stdA, stdB ] = extractMeanCImgLAB( IRGBCropped, IMaskC);
%
% Foreground values are 1, background values are 0

FOREGROUND=1;

% Reading background image
ILABCropped=rgb2lab(IRGBCropped); % LAB colour space

IMask=IMaskC;

[rowSize, colSize, ~]=size(IRGBCropped);

sumL=double(0.0);
sumA=double(0.0);
sumB=double(0.0);
pixelCounter=double(0.0);

% variables for calculating variance
varianceSumL=double(0.0);
varianceSumA=double(0.0);
varianceSumB=double(0.0);

% iterating over the mask
for f=1:1:rowSize
    for c=1:1:colSize
        % Read from the mask image if the value is different from zero
        pixelMask=IMask(f,c);
        if pixelMask == FOREGROUND
            sumL=double(ILABCropped(f,c,1))+sumL;
            sumA=double(ILABCropped(f,c,2))+sumA;
            sumB=double(ILABCropped(f,c,3))+sumB; 
            pixelCounter=pixelCounter+1;
        end
    end
end


% --------------------------------------
% mean values calculated by channels
%---------------------------------------
meanL=double(sumL/pixelCounter); % mean L channel
meanA=double(sumA/pixelCounter); % mean A channel
meanB=double(sumB/pixelCounter); % mean B channel

%------------------------------------------------------------------------
% Sample variance
%------------------------------------------------------------------------
for f=1:1:rowSize
    for c=1:1:colSize
        % Read from the mask image if the value is different from zero
        pixelMask=IMask(f,c);
        if pixelMask == FOREGROUND            
            varianceSumL=varianceSumL+(ILABCropped(f,c,1)-meanL)^2;
            varianceSumA=varianceSumA+(ILABCropped(f,c,2)-meanA)^2;
            varianceSumB=varianceSumB+(ILABCropped(f,c,3)-meanB)^2;            
        end
    end
end
% -----------------------------------------------------------------------

stdL=sqrt(varianceSumL/(pixelCounter));
stdA=sqrt(varianceSumA/(pixelCounter));
stdB=sqrt(varianceSumB/(pixelCounter));

end


