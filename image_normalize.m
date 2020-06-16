function image_e = image_normalize(image)

maximage = max(image(:));
minimage = min(image(:));

image_n = (image-minimage)/(maximage-minimage);

image_s = (image_n(:)).^0.1;
meanv = mean(image_s);
meanv = meanv^10;

ratio = 0.3/meanv;
image_e = image_n*ratio;

image_e = min(image_e,1);
image_e = max(image_e,0);

end