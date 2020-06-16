function map_scale  = getMapScale(src,dst_c,thr_lo,thr_hi)

src     = src(:);
dst     = dst_c(:);
loe     = prctile(src,thr_lo);
hie     = prctile(src,thr_hi);

mask    = src >= loe & src <= hie;
src     = src(mask);
dst     = dst(mask);

map_scale   = dst\src;

end