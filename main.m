function main

% read .lis file for listing input image files

tic()
fimg    = fopen('img_test.lis');
f_img   = fgetl(fimg);

maskx1  = [0,0,0;1,-1,0;0,0,0];
maskx2  = [0,0,0;0,1,-1;0,0,0];
imsize  = 180;
mask_r  = true(imsize,imsize);

for i = 1:imsize
    for j = 1:imsize
        if norm([i,j] - [imsize/2,imsize/2]) >= imsize/2
            mask_r(i,j) = false;
        end
    end
end

% pre-defined sparse matrix for images with size imsizeximsize
sp_mat  = sparse_matrix(imsize,imsize);
f_cell  = {};
index   = 0;

while ischar(f_img)    
    index = index+1;
    f_cell{index} = f_img;
    f_img = fgetl(fimg);
end

disp('begin loop...')
for i = 1:index
    
    f_img       = f_cell{i};
    f_new       = strrep(f_img, '.', '_cii.');
    
    image       = double(imread(f_img));  
    image       = max(double(image),1);
    [lu, lv, mask ]     = img2uv(image);

%   2D CII based
    [ im_min_u, im_max_u, im_min_v, im_max_v ] = L1_chromaticity( lu, lv, mask );
    edge        = edge_detection_2d_sobel(im_min_u, im_max_u, im_min_v, im_max_v) & mask & mask_r;
    image_new   = poisson_image_mint(image, sp_mat, edge, maskx1, maskx2, maskx1', maskx2');

    imwrite(image_new,f_new);
end

fclose(fimg);
toc()

end