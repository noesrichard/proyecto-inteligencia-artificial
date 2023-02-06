%%
% Region props para separa areas grandes y evaluar esas  areas grandes con
% con quadtree
%%

clc; clear; close all;


img = imread('images\yo.jpg');

img = imresize(img, 0.25);

gray_img = rgb2gray(img);
bin_img = imbinarize(gray_img);
bin_img = im2bw(gray_img); 
x = edge(gray_img, 'canny');
figure;
imshow(bin_img);

mask = bwconvhull(x,"objects");
%imshow(mask);

%%
bi=gray_img<255;
bi = ~bin_img; 
% subplot(2,2,1);
imshow(bi);

% [a,b]=bwlabel(bi,8);
% disp(b);
detected_edge=edge(gray_img,'canny', 0.2);
% subplot(2,2,2);
imshow(detected_edge);

edges=imclose(detected_edge,strel('disk',3));
% subplot(2,2,3);
imshow(edges);

%%
binary_operation=bwareaopen(bitxor(bi,edges),50);
% subplot(2,2,4);
imshow(binary_operation);

props = regionprops(binary_operation,'BoundingBox', 'Area');
imshow(binary_operation);
hold on
for i = 1: length(props)
    rectangle('Position',props(i).BoundingBox,'EdgeColor', 'r' );
end
hold off


[aa,b]=bwlabel(binary_operation,8);
disp(b);

[B, L] = bwboundaries(binary_operation); % Rastrea los bordes exteriores de cada objeto
imshow(label2rgb(L, @jet, [.5 .5 .5]));
hold on

for k = 1: length(B) boundary = B{k};
    plot(boundary(:, 2), boundary(:,1), 'w', 'LineWidth', 2)
end

%%
clc; close all; 
bw = binary_operation;
bw = bwareaopen(bw,100,4);
imshow(bw)
se = strel('disk',2);
bw = imclose(x,se);
imshow(~bw)

%%
clc; close all; 

BW = ~bw;
[B,L,N,A] = bwboundaries(BW);
imshow(L); hold on;
colors=['b' 'g' 'r' 'c' 'm' 'y'];
for k=1:length(B)
    boundary = B{k};
    cidx = mod(k,length(colors))+1;
    boundary = B{k};
    if(k > N)
        plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
    else
        plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
    end

    %randomize text position for better visibility
    rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
    col = boundary(rndRow,2); row = boundary(rndRow,1);
    h = text(col+1, row-1, num2str(L(row,col)));
    set(h,'Color',colors(cidx),'FontSize',14,'FontWeight','bold');
end

propiedades = regionprops(L, 'Area','Centroid', 'BoundingBox','Image');
treshold = 0.94;
% 
% for i = 1 : length(B)
%                 figure(i + 1);
%                 imgCrop = imcrop(img, propiedades(i).BoundingBox);
%                 
%                 size(imgCrop);
%                 imshow(imgCrop); 
%                 
% end

%%
% props = regionprops(binary_operation, 'Area', 'Centroid','BoundingBox', 'Image', ...
%     'FilledImage', 'Extrema', 'Orientation','MajorAxisLength', 'MinorAxisLength', ...
%     'ConvexHull');
% biggest_area = find([props.Area] == max([props.Area]));
% biggest_area_props = props(biggest_area);
% imshow(binary_operation);
% hold on
% x = biggest_area_props.ConvexHull(:,1);
% y = biggest_area_props.ConvexHull(:,2);
% plot(x,y, 'r-');
% hold off
% title('5. ConvexHuell')

%% a

imshow(img);
hold on
for i=1: length(props)
    rectangle('position', props(i).BoundingBox, 'EdgeColor','r');
end
hold off
title('BoudingBox')

% bw =
% bw = bwareaopen(bw,30);
% imshow(bw)
% se = strel('disk',2);
% bw = imclose(x,se);
% imshow(bw)

%%
% clc;
% a = ~double(edges(:,:));
% red = double(img(:,:,1));
% blue = double(img(:,:,2));
% green = double(img(:,:,3));
%
% new_red = red.*a;
% new_blue = blue.*a;
% new_green = green.*a;
% img_final_2(:,:,1) = new_red;
% img_final_2(:,:,2) = new_blue;
% img_final_2(:,:,3) = new_green;
%
% img_final_2 = uint8(img_final_2);
% subplot(2,2,4);
% imshow(img_final_2);


