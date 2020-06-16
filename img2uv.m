function [ lu, lv, mask ] = img2uv( img )

filter  = [0,1,0;1,1,1;0,1,0];
R       = img(:,:,1);
G       = img(:,:,2);
B       = img(:,:,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% highlight mask
% V       = zeros(3,size(img,1)*size(img,2));
% 
% for i = 1:3
%     V(i,:) = reshape(img(:,:,i),1,[]);
% end
% 
% [~,H]   = nmfsc(V,2,[],0.75);
% hl      = reshape(H(2,:),size(img,1),size(img,2));
% mask_hl = hl <= 0.015;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ref     = (R.*G.*B).^(1/3);

ref_lo  = prctile(ref(:),1);
ref_up  = prctile(ref(:),99);
mask    = (ref <= ref_up & ref >= ref_lo);

% mask    = mask_hl & nonzero;
r       = R./ref;
g       = G./ref;
b       = B./ref;

lr      = log(r);
lg      = log(g);
lb      = log(b);

[lu,lv] = projecting_32(lr,lg,lb);

end