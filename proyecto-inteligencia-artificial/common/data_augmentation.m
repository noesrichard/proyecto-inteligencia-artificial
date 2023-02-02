function full_dataset = data_augmentation(dataset_path, save_path)
    
    full_dataset = readmatrix(dataset_path); 
    
    window = 5; 
    
    for label = 1 : 10
    
        indexs = find(full_dataset(:,end) == label); 
        dataset = full_dataset(indexs,1:end-1);
        
        [rows, columns] = size(dataset); 
        blocks = floor(rows/window); 
        
        begin = 1;
        end_ = window; 
        
        for i = 1 : blocks
            sub_dataset = dataset(begin:end_,:); 
        
            [sub_rows, sub_columns] = size(sub_dataset); 
        
            maxs = round(max(sub_dataset)); 
            mins = round(min(sub_dataset));  
    
            means = round(mean(sub_dataset)); 
            medians = round(median(sub_dataset)); 
            
            for j = 1 : sub_rows
                new_row = []; 
                new_row_2 = [];
                for k = 1 : sub_columns
                    new_row(k) = randi([mins(k) maxs(k)]);
                    if medians(k) < means(k)
                        new_row_2(k) = randi([medians(k) means(k)]);
                    end
                    if means(k) < medians(k)
                        new_row_2(k) = randi([means(k) medians(k)]);
                    end
                    if means(k) == medians(k)
                        new_row_2(k) = medians(k); 
                    end
                     
                end
        
                sub_dataset = [sub_dataset; new_row; new_row_2]; 
            end
        
            begin = begin + window; 
            end_ = end_ + window; 
             
            dataset = [dataset; sub_dataset]; 
        end
        dataset(:, end+1) = label; 
        full_dataset = [full_dataset; dataset]; 
    end
    
    delete(fullfile(save_path));
    xlswrite(save_path,full_dataset);

end