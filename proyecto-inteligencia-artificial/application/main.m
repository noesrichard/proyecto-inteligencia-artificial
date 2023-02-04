clc; clear; close all; 


webcamlist

cam = webcam('Integrated');  
preview(cam); 

while true
    img = snapshot(cam); 
    threshold = 0.5;
    resize = 512; 
    dims = [512 256 128 64 32]; 
    tic
        [unique_predictions, predictions] = predict_quadtree(img,resize,threshold, dims, 'ann', true);
    toc
    
end