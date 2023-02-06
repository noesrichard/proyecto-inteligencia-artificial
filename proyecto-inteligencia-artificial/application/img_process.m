img = imread('images\person.jpg');
img = imresize(img,0.50); % reducir tamanio en un 50%
imshow(img)
pause(0.50);

img = rgb2gray(img); %escala grises
imshow(img)
pause(0.50);

img = medfilt2(img); %limpiar ruido
imshow(img);
pause(0.20);

img = img * 1.50; %aumentar contraste
imshow(img);
pause(0.20);

img = im2bw(img); %binarizar imagen
imshow(img)
pause(0.50);

img = imcomplement(img);
imshow(img)
pause(0.50);

img = bwareaopen(img,700); %eliminar ruido de regiones pequeñas
imshow(img)
pause(0.20);

se = strel('disk', 3); %conectar pixeles de un mismo objeto
img = imclose(img, se);
imshow(img)
pause(0.20);