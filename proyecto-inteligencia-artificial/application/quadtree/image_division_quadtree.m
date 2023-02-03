%% Image process
clc; clear; close all;
warning("off", "all");

img_path = 'images\yo.jpg';
tic
img = imread(img_path);

[image, modified_image, gray_image, bw_image] = preprocess_image(img, 512);


%% Quadtree
clc; close all;

S = qtdecomp(gray_image,0.2);
sizes = [512 256 128 64];
boxes = [];
coords = [];
for dim = sizes
    [values, rows, columns] = qtgetblk(gray_image,S,dim);
    dims = repmat(dim,size(rows));
    boxes = [boxes; columns rows dims dims];
    coords = [coords; rows rows+dim-1 columns columns+dim-1];
end

predictions = []; 
subplot(1,2,1);
imshow(modified_image);
hold on
for index = 1: length(boxes)
    sub_img = get_sub_image(modified_image,coords(index,:)); 
    %sub_img = modified_image(coords(index,1):coords(index,2),coords(index,3):coords(index,4),:);
    prediction = predict_matrix_image(sub_img,'knn');

    prediction = convertCharsToStrings(prediction);

    color = 'k';
    if contains(prediction, 'black') || contains(prediction, 'grey')
        color = 'w';
    end

    

    text('Position',[boxes(index,1) boxes(index,2)+10],'String',prediction, 'Color',color);
    rectangle('position', boxes(index,:), 'EdgeColor','r','LineWidth',2);

    predictions = [predictions; index prediction];
end
hold off
title('BoundingBox')
predictions_founded = unique(predictions(:,2));
toc




