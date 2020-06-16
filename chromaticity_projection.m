% projecting the lu and lv, to chromatricity image; ci = lu*cos(theta) + lv*sin(theta)
function ci = chromaticity_projection(lu, lv, theta)

ci = lu*cosd(theta)+lv*sind(theta);

end