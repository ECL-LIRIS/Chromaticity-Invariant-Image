function [l_u, l_v] = projecting_22(lu, lv, theta)
% linear projection onto a line with angle theta

P = [cosd(theta)*cosd(theta), cosd(theta)*sind(theta); ...
    cosd(theta)*sind(theta), sind(theta)*sind(theta) ];

L = zeros(size(lu,1),size(lu,2),2);

for i = 1 : size(lu,1)
    for j = 1 : size(lu,2)
    
        L(i,j,:) = P*[lu(i,j) lv(i,j)]';       
    
    end
end

l_u = L(:,:,1);
l_v = L(:,:,2);

end