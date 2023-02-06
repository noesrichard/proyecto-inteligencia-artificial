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
        predictions = predict(image,boxes,algo, component);
        hold(component,'off');
    catch 
        
    end

end


function  predictions = predict(image, boxes, algo, component)

    predictions = [];

    for i = 1: length(boxes)
    
        sub_img = imcrop(image, boxes(i,:));
        
        prediction = predict_matrix_image(sub_img,algo);
    
        prediction = convertCharsToStrings(prediction);
        
        draw_prediction(prediction, boxes(i,:), component);
       
        predictions = [predictions; i prediction];
    end

end

function draw_prediction(prediction, box, component)
    color = set_color(prediction);
    text(component, 'Position',[box(:,1) box(:,2)+10],'String',prediction, 'Color',color);
    rectangle(component, 'position', box(:,:), 'EdgeColor','r');
end

function color = set_color(prediction)
    color = 'k';
    if (contains(prediction, 'black') || contains(prediction, 'grey') ...
           || contains(prediction, 'blue') )
        color = 'w';
    end
end
