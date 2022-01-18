function R = Resitance(x,y,d,h,a,phi,p)
  
    R = (((x-d).^2+(y-h).^2+a^2-2*a.*(x-d).*cos(phi)).^(p/2));
    
endfunction
