clc; clear; close all; 
vid = videoinput('winvideo', 1);
% vidInfo = imaqhwinfo(vid);
% vidRes = vid.VideoResolution;
% imWidth = vidRes(1);
% imHeight = vidRes(2);
% numBands = vid.NumberOfBands;
% hFig = figure;
% hAxes = axes(hFig);
% hImage = image(hAxes, zeros(imHeight, imWidth, numBands, vidInfo.NativeDataType));
% preview(vid, hImage);
pause(3); 
while true
    img = getsnapshot(vid); 
    predictions = predict_quadtree(img,512,0.5, [512 256 18 64], 'knn', true);
    %redictions = app_predict_quadtree(img,512,0.5,[512 256 18 64], 'ann', hAxes);
end