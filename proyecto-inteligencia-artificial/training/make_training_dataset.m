clc; clear; close all;

warning('off', 'all'); 
data_directory = dir("training\data\");
save_path_dataset = "training\dataset.xlsx";
save_path_labels = "training\labels.xlsx"; 

make_dataset(data_directory, save_path_dataset, save_path_labels); 