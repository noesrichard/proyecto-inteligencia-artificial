%% Quadtree
clc; clear; close all; 

warning("off", "all"); 
webcamlist

cam = webcam('Integrated');   

while true
    img = snapshot(cam); 
    threshold = 0.5;
    resize = 512; 
    dims = [512 256 128 64 32]; 
    tic
    try
        predictions = predict_quadtree(img,resize,threshold, dims, 'ann', true);
    catch
    end
    toc
    
end


%% RegionProps

clc; clear; close all; 

warning("off", "all"); 
webcamlist

cam = webcam('Integrated');  

while true
    img = snapshot(cam); 
 
    tic
       predictions = predict_regionprops(img,'ann',false, 0.15);
    toc
    
end
