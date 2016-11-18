function dis = newDis(disOld,u)
tempArray = -4*u*disOld/3;
dis = 0.25*(1-exp(tempArray));
end