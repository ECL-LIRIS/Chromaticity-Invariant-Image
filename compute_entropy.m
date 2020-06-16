% compute Shannon's entropy for an image

function entropy = compute_entropy(ci)

As = sort(ci);

% only use the middle 98% of the image in gray level to avoid the outlier
outlier = [0.01 0.99];
B = As(floor(outlier(1)*length(As)) : floor(outlier(2)*length(As)));

%bin_width = 3.49*length(B)^(-1/3)*std(B);           % Scott's rule
bin_width = 2*iqr(B)*(length(B)^(-1/3));            % Freedman - Diaconis rule's choice
bin_num = ceil(range(B)/bin_width);               

bin = hist(B, bin_num);
bin(bin == 0) = [];

prob = bin/sum(bin);
ent = prob.*log2(prob/bin_width);
entropy = -sum(ent);

end