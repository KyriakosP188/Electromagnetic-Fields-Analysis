function [dphi]=Fieldfunction_help(theta,y,z,d,D,b)
ds=b^2/d;
R1 = ((y-d*sin(theta)).^2+(z-d*cos(theta)-D).^2).^(1/2);
R2= ((y-ds*sin(theta)).^2 + (z-ds*cos(theta)-D).^2).^(1/2);
dphi=d./R1 - b./R2;  % + 1; 
endfunction 
