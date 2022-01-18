function y=fun(phi2,a,rt,phi)
y=cos(phi2).*log(a./(rt.^2 +a^2 -2.*rt.*a*cos(phi-phi2)).^(1/2));
end
