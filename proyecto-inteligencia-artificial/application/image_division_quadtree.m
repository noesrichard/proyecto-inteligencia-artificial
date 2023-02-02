%% Image process
clc; clear; close all; 
warning("all", "off");

% webcamlist
% 
% cam = webcam('Integrated'); 
% subplot(1,2,1); 
% preview(cam); 

img_path = 'images\yo2.jpg';

img = imread(img_path);
img(end:1024,:) = 255; 
img = img(:,1:1024,:);
imshow(img); 

[rows, columns, dpeth] = size(img); 
rows = round(rows/2)-256; 
columns = round(columns/2)-256;

img_reduced(:,:,1) = img(rows:rows+511, columns:columns+511,1); 
img_reduced(:,:,2) = img(rows:rows+511, columns:columns+511,2);
img_reduced(:,:,3) = img(rows:rows+511, columns:columns+511,3);

img_reduced = img; 

gray_img = rgb2gray(img);
imgBw = im2bw(gray_img); 

%gray_img = gray_img(rows:rows+511, columns:columns+511);


%% Quadtree
clc; close all; 
S = qtdecomp(gray_img,0.6);  
sizes = [512 256 128 64 32 16 8 4 2 1]; 
sizes = [512 256 128 64];

coords = []; 
boxes = []; 
for dim = sizes
    [values, rows, columns] = qtgetblk(gray_img,S,dim);
    for i = 1: length(columns)
        row_start = rows(i);
        row_end = row_start + dim-1; 
        column_start = columns(i); 
        column_end = column_start + dim-1;
        boxes = [boxes; columns(i) rows(i) dim dim];
        coords = [coords; row_start row_end column_start column_end]; 
    end
end

subplot(1,2,1);
imshow(img_reduced);
hold on
for i = 1: length(boxes) 
    sub_img = img_reduced(coords(i,1):coords(i,2),coords(i,3):coords(i,4),:); 
    a = predict_matrix_image(sub_img,'knn'); 
    a = convertCharsToStrings(a);
    color = 'k';
    if contains(a, 'black') || contains(a, 'grey')
        color = 'w'; 
    end
    text('Position',[boxes(i,1) boxes(i,2)+10],'String',a, 'Color',color);
    rectangle('position', boxes(i,:), 'EdgeColor','r','LineWidth',2);
end
hold off
title('BoundingBox')

predictions = []; 
unique_p = []; 
for i = 1: length(coords)
    sub_img = img_reduced(coords(i,1):coords(i,2),coords(i,3):coords(i,4),:); 
    a = predict_matrix_image(sub_img,'knn'); 
    a = convertCharsToStrings(a);
    p = [i a]; 
    predictions = [predictions; p]; 
    unique_p = [unique_p; a]; 
    %predictions = [predictions a]; 
    %predictions = unique(predictions);
end
unique_p = unique(unique_p);
% predictions = predictions';
% subplot(1,2,2);
% i = 15;
% sub_img = img_reduced(coords(i,1):coords(i,2),coords(i,3):coords(i,4),:); 
% imshow(sub_img); 
% title('Sub image');



