clc; clear; close all; 


img = imread('images\zoro.jpg'); 
gray_img = rgb2gray(img); 
x = edge(gray_img, 'sobel'); 

imshow(x); 

mask = bwconvhull(x,"objects"); 
%imshow(mask); 

%% 
bi=gray_img<255;
figure;
imshow(bi);

[a,b]=bwlabel(bi,8);
disp(b);
detected_edge=edge(gray_img,'canny');
figure;
imshow(detected_edge);

edges=imclose(detected_edge,strel('disk',3));
figure;
imshow(edges);

%% 
binary_operation=bwareaopen(bitxor(bi,edges),50);
figure;
imshow(binary_operation);
[a,b]=bwlabel(binary_operation,8);
disp(b);

%% a
bw = bwareaopen(bw,30);
imshow(bw)
se = strel('disk',2);
bw = imclose(x,se);
imshow(bw)

%%
clc;
a = double(edges(:,:)); 
red = double(img(:,:,1)); 
blue = double(img(:,:,2)); 
green = double(img(:,:,3)); 

new_red = red.*a; 
new_blue = blue.*a; 
new_green = green.*a; 
img_final_2(:,:,1) = new_red; 
img_final_2(:,:,2) = new_blue; 
img_final_2(:,:,3) = new_green;

img_final_2 = uint8(img_final_2);
imshow(img_final_2); 

%% 
props = regionprops(binary_operation,'BoundingBox', 'Area'); 
imshow(img); 
hold on
for i = 1: length(props)
   
        rectangle('Position',props(i).BoundingBox); 
  
end
hold off

