clc; clear; close all;
warning("off", "all"); 
tic
img = imread('images\zoro.jpg');

img = imresize(img, 0.25);

gray_img = rgb2gray(img);

bw_img = ~imbinarize(gray_img);

props = regionprops(bw_img,'Area', 'BoundingBox'); 
boxes = []; 
imshow(bw_img);
hold on
for i = 1: length(props)
    boxes = [boxes; props(i).BoundingBox]; 
    rectangle('Position',boxes(i,:),'EdgeColor', 'r' );
end
hold off

%%
for i = 1 : length(boxes)
    box = boxes(i,:); 
    width = box(3); 
    height = box(4); 
%     max = width; 
    min = width; 
%     if height > width
%         max = height; 
%     end

    if height < width
        min = height; 
    end

    %sizes = [512 256 128 64 32];
    sizes = [16 32 64 128 256 512]; 

    new = 0; 
    for s = sizes
%         if s > max
%             new = s; 
%         end

        if s < min
            new = s; 
        end
    end
    center = new / 2; 
    dif_columns = (box(4) - new)/2; 
    dif_rows = (box(3) - new)/2; 
    box(1) = box(1)+dif_rows; 
    box(2) = box(2)+dif_columns; 
    box(3) = new; 
    box(4) = new; 
    boxes(i,:) = box; 
end

%%
imshow(bw_img);
hold on
for i = 1: length(boxes) 
    rectangle('Position',boxes(i,:),'EdgeColor', 'r' );
end
hold off

%%
imshow(img); 
hold on
for i = 1: length(boxes) 
    rectangle('Position',boxes(i,:),'EdgeColor', 'r' );
end
for i = 1: length(props)

    if boxes(i,3) >= 8
        sub_img = imcrop(img, boxes(i,:)); 

        [rows, columns, ~] = size(sub_img); 

        dif_rows = boxes(i,3) - rows; 
        dif_columns = boxes(i,3) - columns; 

        sub_img(end:end+dif_rows,:,:) = sub_img(end-dif_rows:end,:,:); 

        sub_img(:,end:end+dif_columns,:) = sub_img(:,end-dif_columns:end,:); 

        if dif_rows < 0
            sub_img = sub_img(1:end+dif_rows,:,:);
        end
        if dif_columns < 0
            sub_img =sub_img(:,1:end+dif_columns,:); 
        end

%         imshow(sub_img);
%         rectangle('Position',boxes(i,:),'EdgeColor', 'r' );
     
        gray_sub_img = im2gray(sub_img); 
        [S, qt_boxes, coords] = quadtree(gray_sub_img,0.5,[512 256 128 64 32 16]);
        qt_boxes(:,1) = qt_boxes(:,1)+boxes(i,1); 
        qt_boxes(:,2) = qt_boxes(:,2)+boxes(i,2); 
        predictions = predict_and_draw_quads_rp(img, qt_boxes, 'ann'); 
    end

end

hold off
toc



