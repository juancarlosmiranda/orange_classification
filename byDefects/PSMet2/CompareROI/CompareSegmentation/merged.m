function [ ] = merged(maskNameExpert, maskNameSoftware, maskNameFinal)
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

IExp=imread(maskNameExpert);
ISoft=imread(maskNameSoftware);

%% 
grayLevel=graythresh(IExp);
IBExp=im2bw(IExp,grayLevel);

%% 
grayLevel=graythresh(ISoft);
IBSoft=im2bw(ISoft,grayLevel);
final=bitor(IBExp,IBSoft);
imwrite(final,maskNameFinal,'jpg');

end