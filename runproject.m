clear;
clc
close all;

cel_nauki = 0;
ilosc_cylki_uczacych = 1000;

% Parameters
hiddenSizeRGB2HSV = [8 5];
hiddenSizeHSV2RGB = [8 5];

% Data size
samples = 1000;

input = uint8(rand(3,samples)*255);
output = rgb2hsv(input')';
output2 = hsv2rgb(output')';

img = imread('lena.jpg');
%img = imread('monalisa.jpg');
%img = imread('flower.jpg');

%Alternatywnie mozna zaladowac sieci neuronowa z pliku
load('netRGB2HSV');
%siecRGB2HSV;

showRGB2HSV;

%Alternatywnie mozna zaladowac sieci neuronowa z pliku
load('netHSV2RGB');
%siecHSV2RGB;

showHSV2RGB;

save('netHSV2RGB', 'netHSV2RGB');
save('netRGB2HSV', 'netRGB2HSV');