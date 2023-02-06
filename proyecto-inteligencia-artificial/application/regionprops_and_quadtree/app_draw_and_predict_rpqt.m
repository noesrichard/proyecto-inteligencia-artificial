function predictions = app_draw_and_predict_rpqt(image, boxes, algo, component)
%     imshow(image);
%     hold on
    predictions = predict(image, boxes, algo, component); 
%     hold off
end

function  predictions = predict(image, boxes, algo, component)

    predictions = [];

    for i = 1: size(boxes,1)
    
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