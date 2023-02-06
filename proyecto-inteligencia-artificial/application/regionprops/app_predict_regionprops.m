function predictions = app_predict_regionprops(image, algo,negative, component, bw_component)
    gray_image = rgb2gray(image);
    bw_image = imbinarize(gray_image);
    
    if negative
        bw_image = ~bw_image;
    end

    imshow(bw_image, 'Parent', bw_component)
    props = regionprops(bw_image, 'Area', 'BoundingBox');
    
    props = struct2table(props); 
    props = sortrows(props, 'Area','descend'); 
    props = table2struct(props); 
    
    predictions = []; 
    boxes = [];
    i = 1; 
    try
        imshow(image, 'Parent', component);
        hold(component,'on'); 
        while props(i).Area > 100
            box = props(i).BoundingBox; 
            boxes = [boxes; box(1,1) box(1,2) box(1,3) box(1,4)];
            i = i + 1; 
        end
        predictions = app_predict(image,boxes,algo, component);
        hold(component,'off');
    catch 
        
    end

end



