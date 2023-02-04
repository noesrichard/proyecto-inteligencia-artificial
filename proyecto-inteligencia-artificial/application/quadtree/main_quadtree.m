%% Settings
clc; clear; close all; 
warning("off", "all"); 

%% Select img

img = imread('images\person.jpg'); 
threshold = 0.5;
dims = [512 256 128 64]; 
resize = 512; 
tic
[unique_predictions, predictions] = predict_quadtree(img,rresize,threshold, dims, 'ann', true);
toc