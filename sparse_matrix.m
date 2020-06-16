function sp_mat = sparse_matrix( h, w )

mi = [];
mj = [];
ms = [];

for i = 1:w
    for j = 1:h
        mi = [mi (i-1)*h+j];
        mj = [mj (i-1)*h+j];
        if (i-1)*(i-w) ~= 0 && (j-1)*(j-h) ~= 0
            ms = [ms -4];
        elseif (i-1)*(i-w) == 0 && (j-1)*(j-h) == 0
            ms = [ms -2];
        else
            ms = [ms -3];
        end
        if i > 1
            mi = [mi (i-1)*h+j];
            mj = [mj (i-2)*h+j];
            ms = [ms 1];
        end
        if i < w
            mi = [mi (i-1)*h+j];
            mj = [mj i*h+j];
            ms = [ms 1];
        end
        if j > 1
            mi = [mi (i-1)*h+j];
            mj = [mj (i-1)*h+j-1];
            ms = [ms 1];
        end
        if j < h
            mi = [mi (i-1)*h+j];
            mj = [mj (i-1)*h+j+1];
            ms = [ms 1];
        end
    end
end

sp_mat = sparse(mi,mj,ms,h*w,h*w);

end

