clc; clear; close all; 
img = imread('images\3.jpg'); 


predictions = predict_regionprops_quadtree(img,'ann', true); 


%% Quadtree
clc; clear; close all; 

warning("off", "all"); 
webcamlist

cam = webcam('Integrated');   

while true
    img = snapshot(cam); 
    threshold = 0.5;
    resize = 1; 
    dims = [64 32]; 
    tic
    try
       predictions = predict_regionprops_quadtree(img,'ann', true); 
    catch
    end
    toc
   
end