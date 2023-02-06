function  predictions = predict_quadtree(img, resize, threshold, dims,algo, draw)

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

    imshow(image)
    hold on

    if length(bxs1) > 4
        if draw
            predictions = draw_predictions_qt(image, bxs1, algo);
        else
            predictions = predict_quads(image, bxs1, algo);
        end
    end
    if length(bxs2) > 4
        if draw
            predictions = draw_predictions_qt( image,  bxs2, algo);
        else
            predictions = predict_quads( image,  bxs2, algo);
        end
    end
    if length(bxs3) > 4
        if draw
            predictions = draw_predictions_qt( image,  bxs3, algo);
        else
            predictions = predict_quads( image,  bxs3, algo);
        end
    end
    if length(bxs4) > 4
        if draw
            predictions = draw_predictions_qt( image,  bxs4, algo);
        else
            predictions = predict_quads( image,  bxs4, algo);
        end
    end
    hold off
  

end

