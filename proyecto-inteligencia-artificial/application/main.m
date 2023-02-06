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
       predictions = predict_regionprops(img,'ann',true, 0.15);
    toc
    
end

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

