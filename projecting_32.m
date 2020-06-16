%
function [lu, lv] = projecting_32(lr,lg,lb)

h       = size(lr,1);
w       = size(lr,2);

lr      = lr(:);
lg      = lg(:);
lb      = lb(:);
lrgb    = [lr,lg,lb];

% P       = eye(3) - power(1/sqrt(3),2)*ones(3,3);
% [V,~]   = eig(P);
% V(:,2)  = -1*V(:,2);
% U       = V(:,2:3);
U = [1/sqrt(6), 1/sqrt(6), -2/sqrt(6);1/sqrt(2), -1/sqrt(2), 0]; % eigens

luv     = lrgb*U';
lu      = reshape(luv(:,1),h,w);
lv      = reshape(luv(:,2),h,w);

end