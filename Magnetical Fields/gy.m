function y=dhelpy(phi2,a,rt,phi,xx)
y=((xx-a.*cos(phi2)).*cos(phi2))./(rt.^2+a^2-2.*rt.*a.*cos(phi-phi2));
end