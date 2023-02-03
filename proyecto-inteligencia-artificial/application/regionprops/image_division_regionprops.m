%% Image process
clc; clear; close all;
warning("off", "all");
m = 1
n = 3; 

img_path = 'images\yo.jpg';

image = imread(img_path);

[image, modified_image, gray_image, bw_image] = preprocess_image(image, 0);

bw_image = ~imbinarize(gray_image); 

props = regionprops(bw_image, 'Area', 'BoundingBox', 'Image'); 
biggest_area = find([props.Area] == max([props.Area]));
biggest_area_props = props(biggest_area);

%% Bounding box
imshow(image);
hold on
for area = 1: 7
    current_area = props(area); 
    for i=1: length(current_area)
        rectangle('position', current_area.BoundingBox, 'EdgeColor','r','LineWidth',2);
    end
end

hold off
title('BoudingBox')
%% boundaries

[B,L] = bwboundaries(bw_image,'noholes');
imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end


%% Boundarise over
[B,L,N,A] = bwboundaries(bw_image);
imshow(image); hold on;
colors=['b' 'g' 'r' 'c' 'm' 'y'];
for k=1:length(B),
  boundary = B{k};
  cidx = mod(k,length(colors))+1;
  plot(boundary(:,2), boundary(:,1),...
       colors(cidx),'LineWidth',2);

  %randomize text position for better visibility
  rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
  col = boundary(rndRow,2); row = boundary(rndRow,1);
  h = text(col+1, row-1, num2str(L(row,col)));
  set(h,'Color',colors(cidx),'FontSize',14,'FontWeight','bold');
end

