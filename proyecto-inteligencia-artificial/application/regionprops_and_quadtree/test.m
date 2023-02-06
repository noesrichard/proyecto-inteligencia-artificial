clc; clear; close all; 
img = imread('images\zoro.jpg'); 


predictions = predict_regionprops_quadtree(img,'ann',0.5, false); 
found = unique(predictions(:,2)); 


%% Ambos
clc; clear; close all; 

warning("off", "all"); 
webcamlist

cam = webcam('Integrated');   

while true
    img = snapshot(cam); 
    threshold = 0.5; 
    negative = false; 
    tic
    try
       predictions = predict_regionprops_quadtree(img,'ann', threshold, negative); 
       found = unique(predictions(:,2)); 
    catch
    end
    toc
end