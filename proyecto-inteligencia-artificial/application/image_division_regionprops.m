clc; clear; close all; 

img_path = 'images\yo.jpg';
m = 1;
n = 2;

img = imread(img_path);
imgGray = rgb2gray(img);
imgBw = im2bw(imgGray);

props = regionprops(imgBw, 'Area', 'BoundingBox', 'Image'); 
biggest_area = find([props.Area] == max([props.Area]));
biggest_area_props = props(biggest_area);

%% Bounding box
subplot(m,n,1);
imshow(img);
hold on
for area = 1: 7
    current_area = props(area); 
    for i=1: length(current_area)
        rectangle('position', current_area.BoundingBox, 'EdgeColor','r','LineWidth',2);
    end
end

hold off
title('BoudingBox')

%% region props
props = regionprops(imgBw, 'Area', 'Centroid','BoundingBox');
biggest_area = find([props.Area] == max([props.Area]));
biggest_area_props = props(biggest_area);
imshow(imgBw);
hold on
for i=1: length(props)
    rectangle('position', props(i).BoundingBox, 'EdgeColor','r','LineWidth',2);
end
hold off
title('BoudingBox')

%% Image
subplot(m,n,2);
regionBox = props(biggest_area).BoundingBox;
newImg1 = imcrop(img, regionBox);
imshow(props(biggest_area).Image);
title('Image')

