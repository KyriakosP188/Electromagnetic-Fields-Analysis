function y=dhelpx(phi2,a,rt,phi,yy)
y=((yy-a.*sin(phi2)).*cos(phi2))./(rt.^2+a^2-2.*rt.*a.*cos(phi-phi2));
end