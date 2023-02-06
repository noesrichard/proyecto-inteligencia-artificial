
function predictions = predict_regionprops_quadtree(img, algo, quadtree_threshold, negative)
tic
resize_factor = 0.25;
resized_img = imresize(img, resize_factor);

gray_img = rgb2gray(resized_img);

bw_img = imbinarize(gray_img);

if negative
    bw_img = ~bw_img;
end

props = regionprops(bw_img,'Area', 'BoundingBox');
boxes = get_boxes(props);

predictions = [];
quadtree_boxes = [];
subplot(2,1,1); 
imshow(img);
hold on

for i = 1: size(boxes,1)
    
    drawing_boxes = boxes(:,:)/resize_factor; 
    rectangle('Position',drawing_boxes(i,:),'EdgeColor', 'r' );

    sub_img = imcrop(gray_img, boxes(i,:));


    sub_img = clean_sub_img(sub_img, boxes(i,:)); 


    [~, new_boxes, ~] = quadtree(sub_img,quadtree_threshold,[512 256 128 64 32 16]);

    new_boxes(:,1) = new_boxes(:,1)+boxes(i,1);
    new_boxes(:,2) = new_boxes(:,2)+boxes(i,2);

    quadtree_boxes = [quadtree_boxes; new_boxes];
end
quadtree_boxes = quadtree_boxes/resize_factor; 
h = predict_and_draw_quads_rp(img, quadtree_boxes, algo);
predictions = [predictions; h];
hold off
subplot(2,1,2)
imshow(bw_img); 
toc
end


function boxes = get_boxes(props)
    boxes = [];
    for i = 1 : length(props)
        box = props(i).BoundingBox;
        width = box(3);
        height = box(4);
    
        min = width;
    
        if height < width
            min = height;
        end
    
        sizes = [16 32 64 128 256 512];
    
        new = 0;
        for s = sizes
            if s < min
                new = s;
            end
        end
    
        dif_columns = (box(4) - new)/2;
        dif_rows = (box(3) - new)/2;
    
        box(1) = box(1)+dif_rows;
        box(2) = box(2)+dif_columns;
        box(3) = new;
        box(4) = new;
        boxes = [boxes; box];
    end
    indices = boxes(:,3)==0;
    boxes(indices,:) = [];
end

function sub_img = clean_sub_img(sub_img, box)
    [rows, columns, ~] = size(sub_img);

    dif_rows = box(3) - rows;
    dif_columns = box(3) - columns;


    if dif_rows < 0
        sub_img = sub_img(1:end+dif_rows,:,:);
    end
    if dif_columns < 0
        sub_img =sub_img(:,1:end+dif_columns,:);
    end
end