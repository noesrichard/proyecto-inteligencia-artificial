function observations = make_testing_observations(path, numeric_label)
    observations = []; 
        
        files = dir(fullfile(path, '*.jpg'));
        

        for i = 1 : length(files)

            img_name = strcat(path,files(i).name);

            img = imread(img_name); 
            img = process_image(img); 
            img_name
            
            imgRed = img(:,:,1); % red
            imgGreen = img(:,:,2); % green
            imgBlue = img(:,:,3); % blue
            
           
            meansB = extract_means_vector(imgBlue); 
            meansR = extract_means_vector(imgRed); 
            meansG = extract_means_vector(imgGreen); 
            
            observation = [meansR meansG meansB numeric_label]; 
            observations = [observations; 
                            observation];
        end

end