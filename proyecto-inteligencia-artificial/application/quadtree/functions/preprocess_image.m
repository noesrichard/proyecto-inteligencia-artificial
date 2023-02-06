function [image,gr1, gr2,gr3, gr4] = preprocess_image(image, crop)
%     sizes = [32 64 128 256 512 1024]; 
    image = imresize(image,0.8); 
%     images = []; 
%     modified_image = image;
%     if crop == 512
    im1 = image(1:512,1:512,:);
    
    im2 = image(1:512,end-512+1:end,:);
    
    im3 = image(end-512+1:end,1:512,:);
    
    im4 = image(end-512+1:end,end-512+1:end,:);
    
    
    gr1 = rgb2gray(im1);
    gr2 = rgb2gray(im2);
    gr3 = rgb2gray(im3);
    gr4 = rgb2gray(im4);
    %     end
%     
%     if crop == 0
%         modified_image = image; 
%     elseif crop == 1024
%         modified_image = image;
%         modified_image(end:1024,:,:) = 0; 
%         modified_image(:,end:1024,:) = 0; 
%         modified_image = modified_image(1:1024,1:1024,:);
%     else
%         [rows, columns, ~] = size(image); 
%         limit = rows; 
%         if columns < rows
%             limit = columns;
%         end
%         closest = sizes(1);
%         for s = sizes
%             if limit - s >= 0 
%                 closest = s;
%             end
%         end
%         rows = round(rows/2)-(closest/2); 
%         columns = round(columns/2)-(closest/2); 
%         end_v = closest - 1; 
%         modified_image(:,:,1) = image(rows:rows+end_v, columns:columns+end_v,1); 
%         modified_image(:,:,2) = image(rows:rows+end_v, columns:columns+end_v,2);
%         modified_image(:,:,3) = image(rows:rows+end_v, columns:columns+end_v,3);
%      
%     end
%     
%   
% 
%     gray_image = rgb2gray(modified_image);
%     bw_image = im2bw(gray_image,0.4);
end