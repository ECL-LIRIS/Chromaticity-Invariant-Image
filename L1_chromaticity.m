function [ im_min_u, im_max_u, im_min_v, im_max_v ] = L1_chromaticity( lu, lv, mask )

[~,~,theta_min,theta_max]   = Entropy_minimization1D(lu, lv, mask);

[l_u_min, l_v_min]      = projecting_22(lu, lv, theta_min);
[l_u_max, l_v_max]      = projecting_22(lu, lv, theta_max);

im_min_u   = exp(l_u_min);
im_max_u   = exp(l_u_max);
im_min_v   = exp(l_v_min);
im_max_v   = exp(l_v_max);

end