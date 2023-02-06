function predictions = predict_regionprops(image, algo,negative, level)
    gray_image = rgb2gray(image);
    bw_image = im2bw(gray_image,level);
    
    if negative
        bw_image = ~bw_image;
    end
    props = regionprops(bw_image, 'Area', 'BoundingBox', 'Image');
    
    props = struct2table(props); 
    props = sortrows(props, 'Area','descend'); 
    props = table2struct(props); 
    
    predictions = []; 
    boxes = [];
    i = 1; 
    try
        while props(i).Area > 100
            box = props(i).BoundingBox; 
            boxes = [boxes; box(1,1) box(1,2) box(1,3) box(1,4)];
            i = i + 1; 
        end
        predictions = draw_predictions(image,boxes,algo);
    catch 
        
    end

end