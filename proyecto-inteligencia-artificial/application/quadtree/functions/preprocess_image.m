function [image, modified_image, gray_image, bw_image] = preprocess_image(image, crop)
    sizes = [32 64 128 256 512 1024]; 
    image = imresize(image,0.8); 
    if crop == 0
        modified_image = image; 
    elseif crop == 1024
        modified_image = image;
        modified_image(end:1024,:,:) = 0; 
        modified_image(:,end:1024,:) = 0; 
        modified_image = modified_image(1:1024,1:1024,:);
    else
        [rows, columns, ~] = size(image); 
        limit = rows; 
        if columns < rows
            limit = columns;
        end
        closest = sizes(1);
        for s = sizes
            if limit - s >= 0 
                closest = s;
            end
        end
        rows = round(rows/2)-(closest/2); 
        columns = round(columns/2)-(closest/2); 
        end_v = closest - 1; 
        modified_image(:,:,1) = image(rows:rows+end_v, columns:columns+end_v,1); 
        modified_image(:,:,2) = image(rows:rows+end_v, columns:columns+end_v,2);
        modified_image(:,:,3) = image(rows:rows+end_v, columns:columns+end_v,3);
     
    end
    gray_image = rgb2gray(modified_image);
    bw_image = im2bw(gray_image,0.4);
end