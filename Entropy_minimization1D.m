% entropy minimization

function [image_min,image_max,theta_min,theta_max] = Entropy_minimization1D(lu, lv, mask)

min_entropy = 100000;
max_entropy = -100000;

for theta = 1:1:180
    ci = chromaticity_projection(lu, lv, theta);
    ci = ci(mask);
    entro = compute_entropy(ci);
    
    if max_entropy < entro
        max_entropy = entro;
        theta_max = theta;
    end
end

for theta = 1:1:180
    ci = chromaticity_projection(lu, lv, theta);
    ci = ci(mask);
    entro = compute_entropy(ci);
    
    if min_entropy > entro
        min_entropy = entro;
        theta_min = theta;
    end
end

flag_coarsetofine = 0;

if flag_coarsetofine
    for theta = (theta_min-1: 0.1: theta_min+1)
        ci = chromaticity_projection(lu, lv, theta);
        ci = ci(mask);
        entro = compute_entropy(ci);

        if min_entropy > entro
            min_entropy = entro;
            theta_min = theta;
        end
    end
end

image_min = chromaticity_projection(lu, lv, theta_min);
image_max = chromaticity_projection(lu, lv, theta_max);

end