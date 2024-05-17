function [ ] = coincidence(maskNameExpert, maskNameSoftware, maskNameFinal)
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
nivel=graythresh(IExp);
IBExp=im2bw(IExp,nivel);

%% 
nivel=graythresh(ISoft);
IBSoft=im2bw(ISoft,nivel);
final=bitand(IBExp,IBSoft);
imwrite(final,maskNameFinal,'jpg');

end