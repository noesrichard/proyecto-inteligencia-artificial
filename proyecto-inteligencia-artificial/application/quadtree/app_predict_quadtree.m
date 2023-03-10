function predictions = app_predict_quadtree(img, threshold, dims,algo, component, multi_boxes_flag)


    if multi_boxes_flag
        predictions = multi_boxes(img, threshold, dims, algo, component);
    else
        [rows, columns, ~] = size(img); 
          
        rows = round(rows/2)-(512/2); 
        columns = round(columns/2)-(512/2); 
        end_v = 512 - 1; 
        new_img(:,:,1) = img(rows:rows+end_v, columns:columns+end_v,1); 
        new_img(:,:,2) = img(rows:rows+end_v, columns:columns+end_v,2);
        new_img(:,:,3) = img(rows:rows+end_v, columns:columns+end_v,3);
        predictions = centered(new_img,threshold, dims, algo, component); 
    end
end


function predictions = centered(image, threshold, dims, algo, component)
  
     gray_image = rgb2gray(image); 
    [~, boxes, ~] = quadtree(gray_image,threshold,dims); 

    imshow(image, 'Parent', component);
    if length(boxes) > 4
        hold(component,'on'); 
        predictions = app_predict(image, boxes, algo, component); 
        hold(component,'off');
    end

end

function predictions = multi_boxes(img, threshold, dims, algo, component)

     [image, gr1, gr2, gr3, gr4] = preprocess_image(img, 512);
    [rows, columns, ~] = size(image); 

    [~, bxs1,  ~] = quadtree(gr1, threshold, dims);
    [~, bxs2,  ~] = quadtree(gr2, threshold, dims);
    [~, bxs3,  ~] = quadtree(gr3, threshold, dims);
    [~, bxs4,  ~] = quadtree(gr4, threshold, dims);
    
    bxs2(:,1) = bxs2(:,1)+columns-511;
    bxs3(:,2) = bxs3(:,2)+rows-511;
    bxs4(:,1) = bxs4(:,1)+columns-511;
    bxs4(:,2) = bxs4(:,2)+rows-511;

    predictions = []; 
    imshow(image, 'Parent', component);
    hold(component,'on');
    if length(bxs1) > 4
         
        p1 = app_predict(image, bxs1, algo, component); 
        p2 = app_predict(image, bxs2, algo, component);
        p3 = app_predict(image, bxs3, algo, component);
        p4 = app_predict(image, bxs4, algo, component);
        predictions = [p1; p2; p3; p4]; 
        hold(component,'off');
    end
  
end





