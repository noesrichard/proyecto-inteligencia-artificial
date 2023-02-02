% clc; clear; close all;

warning('off', 'all'); 
data_directory = dir("testing\data\");
save_path_dataset = "testing\dataset.xlsx";
save_path_labels = "testing\labels.xlsx"; 

make_dataset(data_directory, save_path_dataset, save_path_labels); 