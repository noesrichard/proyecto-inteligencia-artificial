clc; clear; close all; 


webcamlist

cam = webcam('Integrated');  

while true
    img = snapshot(cam); 
    %imshow(img); 
    a_predictions = do_quadtree(img); 
    pause(1); 
end