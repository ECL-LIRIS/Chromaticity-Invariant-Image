function [ dst ] = poisson_image_mint( src, sp_mat, edge, maskx1, maskx2, masky1, masky2 )

mask = [0,0.25,0;0.25,0,0.25;0,0.25,0];
warning off;

logi                = log(src);
h                   = size(logi,1);
w                   = size(logi,2);
dst                 = zeros(h,w,3);
edge_p              = false(h+2,w+2);
edge_p(2:h+1,2:w+1) = edge;

for i = 1:3
    
    ch              = zeros(h+2,w+2);
    ch(2:h+1,2:w+1) = logi(:,:,i);
    ch(:,1)         = ch(:,2);
    ch(:,w+2)       = ch(:,w+1);
    ch(1,:)         = ch(2,:);
    ch(h+2,:)       = ch(h+1,:);
    
    imgradx1        = conv2(ch,maskx1,'same');
    imgradx1(edge_p)= 0;
    imgrady1        = conv2(ch,masky1,'same');
    imgrady1(edge_p)= 0;
    
    imgradx2        = conv2(imgradx1,maskx2,'valid');
    imgrady2        = conv2(imgrady1,masky2,'valid');
    imgradxy        = imgradx2+imgrady2;
    
    dst_c           = sp_mat\imgradxy(:);
    dst_c           = reshape(dst_c,h,w);
    dst_c           = exp(dst_c);
    map_scale       = getMapScale(src(:,:,i),dst_c,70,71);
    dst(:,:,i)      = dst_c.*map_scale/255;
    
end

end