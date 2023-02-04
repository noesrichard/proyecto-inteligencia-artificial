%% Settings
clc; clear; close all; 
warning("off", "all"); 

%% Select img

img = imread('images\person.jpg'); 
threshold = 0.5;
dims = [512 256 128 64]; 
resize = 512; 
tic

predictions = predict_quadtree(img,resize,threshold, dims, 'knn', true);

predictions = predict_quadtree(img,resize,threshold, dims, 'knn', false);

toc