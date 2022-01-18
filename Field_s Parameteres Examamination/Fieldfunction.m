function [func] = Fieldfunction(yf,zf,a,d,D,b,Theta)
# That function creates our Ö

R = ((zf-D)^2+yf^2)^(1/2);
r  = (zf^2 + yf^2)^(1/2);

if (R<=b)
    func = integral(@(theta) Fieldfunction_help(theta,yf,zf,d,D,b),-Theta,Theta,'RelTol',1e-6,'AbsTol',1e-12);
    func = func+1;
end

if (R>b && r<=a)
    func=1;
end
if (r>a)
    func=a/r;
end

endfunction
