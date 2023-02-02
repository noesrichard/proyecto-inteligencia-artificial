function observations = make_dataset(data_directory, save_path_dataset, save_path_labels)
    observations = []; 
    
    labels = {}; 
    numeric_labels = [];
    
    for i = 3: length(data_directory)
    
        label = data_directory(i).name; 
        path = strcat(data_directory(i).folder,'\',label,'\');
        numeric_label = i-2; 
    
        observations = [observations; 
            make_dataset_observations(path, numeric_label)];
    
        labels = [labels; label]; 
        numeric_labels = [numeric_labels; numeric_label]; 
    
    end
    
    T = table(labels, numeric_labels); 
    delete(fullfile(save_path_dataset)); 
    delete(fullfile(save_path_labels)); 
    xlswrite(save_path_dataset,observations);
    writetable(T,save_path_labels); 
end