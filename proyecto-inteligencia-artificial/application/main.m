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
        predictions = predict_quadtree(img,resize,threshold, dims, 'knn', true);
    catch
    end
    toc
    pause(3);
    
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

%%

img = imread('images\zoro.jpg'); 
res = imresize(img, 0.3); 
subplot(1,2,1);
imshow(img); 
subplot(1,2,2); 
imshow(res); 