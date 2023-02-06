%% Settings
clc; clear; close all; 
warning("off", "all"); 

%% Select img

img = imread('images\zoro.jpg'); 

threshold = 0.2;
dims = [512 256 128 64 32]; 
resize = 1; 
tic

predictions = predict_quadtree(img,resize,threshold, dims, 'knn', true);

%predictions = predict_quadtree(img,resize,threshold, dims, 'knn', false);

toc