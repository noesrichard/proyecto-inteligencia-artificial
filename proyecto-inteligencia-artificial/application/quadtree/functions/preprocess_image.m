function [image, modified_image, gray_image, bw_image] = preprocess_image(image, crop)
    if crop == 0
        modified_image = image; 
        
    elseif crop == 1024
        modified_image = image;
        modified_image(end:1024,:,:) = 0; 
        modified_image(:,end:1024,:) = 0; 
        modified_image = modified_image(1:1024,1:1024,:);
    else
        [rows, columns, ~] = size(image); 
        rows = round(rows/2)-256; 
        columns = round(columns/2)-256;
        
        modified_image(:,:,1) = image(rows:rows+511, columns:columns+511,1); 
        modified_image(:,:,2) = image(rows:rows+511, columns:columns+511,2);
        modified_image(:,:,3) = image(rows:rows+511, columns:columns+511,3); 
    end
    gray_image = rgb2gray(modified_image);
    bw_image = im2bw(gray_image,0.4);
end