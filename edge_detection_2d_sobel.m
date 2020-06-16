function edge = edge_detection_2d_sobel( im_min_u, im_max_u, im_min_v, im_max_v )

guide_img       = ones(size(im_min_u));

im_min_u        = imguidedfilter(im_min_u,guide_img);
grad_min_u      = imgradient(im_min_u);

im_min_v        = imguidedfilter(im_min_v,guide_img);
grad_min_v      = imgradient(im_min_v);

grad_min        = (grad_min_u.^2 + grad_min_v.^2).^(1/2);
grad_min        = (grad_min-min(grad_min(:))) ./ (max(grad_min(:))-min(grad_min(:)));

im_max_u        = imguidedfilter(im_max_u,guide_img);
grad_max_u      = imgradient(im_max_u);

im_max_v        = imguidedfilter(im_max_v,guide_img);
grad_max_v      = imgradient(im_max_v);

grad_max        = (grad_max_u.^2 + grad_max_v.^2).^(1/2);
grad_max        = (grad_max-min(grad_max(:))) ./ (max(grad_max(:))-min(grad_max(:)));

edge        = (grad_min <= 0.1 & grad_max >= 0.1 & grad_max < 0.45);

end