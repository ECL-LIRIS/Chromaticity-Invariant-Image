function [nlr, nlg, nlb] = projecting_23(nlu,nlv,U)

h       = size(nlu,1);
w       = size(nlu,2);

lu      = nlu(:);
lv      = nlv(:);
luv     = [lv,lu];

lrgb    = luv * U';
nlr     = reshape(lrgb(:,1),h,w);
nlg     = reshape(lrgb(:,2),h,w);
nlb     = reshape(lrgb(:,3),h,w);

end