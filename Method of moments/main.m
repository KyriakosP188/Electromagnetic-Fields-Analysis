%EXERCISE 7_2

%DATA GIVEN
h=0.5;
L=0.5; 
e1 = 1;
e2 = 5;
xmin=-2;
xmax=2; 
zmin=-2;
zmax=2;

%ARRAYS FOR AXIS 
Dx=(xmax-xmin)/60;
Dz=(zmax-zmin)/60;
x1=xmin:(xmax-xmin)/60:xmax; 
z1=zmin:(zmax-zmin)/60:zmax; 
[X,Z] = meshgrid(x1,z1);
F_array = zeros(length(x1),length(z1));

nfig=1;

%POTENTIAL CALCULATION 
for ix = 1:length(x1)
    for iz = 1:length(z1)
        xx1=X(ix,iz);
        zz1=Z(ix,iz);
        if (zz1>=0) 
           F_array(ix,iz)=(1/(4*pi*e1))*log((L-xx1+((L-xx1)^2+(zz1-h)^2)^(1/2))/(-L-xx1+((L+xx1)^2+(zz1-h)^2)^(1/2)))
                    +(1/(4*pi*e1))*((e1-e2)/(e1+e2))*log((L-xx1+((L-xx1)^2+(zz1+h)^2)^(1/2))/(-L-xx1+((L+xx1)^2+(zz1+h)^2)^(1/2)));
        continue
        end
        if (zz1<=0)
            F_array(ix,iz) = (1/(2*pi*(e1+e2)))*log((L-xx1+((L-xx1)^2+(zz1-h)^2)^(1/2))/(-L-xx1+((L+xx1)^2+(zz1-h)^2)^(1/2)));
        continue
        end   
    end 
end 

%PLOTTING POTENTIAL ON XZ SURFACE
figure(nfig) 
hold off 
surface(X,Z,F_array), shading interp
colorbar
axis equal
hold on
cont =[0.01 0.02 0.03 0.04 0.05 0.075 0.1 0.3 0.3 0.4 0.5];
nfig=nfig+1;
figure(nfig);
hold off

[CS,H] = contour(X,Z,F_array,cont,'Linewidth',1);
clabel(CS,H,cont);
axis equal

%ELECTRIC FIELD AXIS ARRAYS
[Ex_array1, Ez_array1] = gradient(F_array,Dx,Dz);
Ex_array = - Ex_array1;
Ez_array = - Ez_array1;


%PLOTTING NORMALIZED ELECTRIC FIELD 
nfig = nfig + 1;
figure(nfig)
hold off
LL = ((Ex_array).^2 + (Ez_array).^2).^(1/2);
quiver(X,Z,Ex_array./LL,Ez_array./LL,0.8); 
hold on
hs = streamslice(X,Z,Ex_array,Ez_array,0.8);
%contour(X,Z,F_array,cont,'Linewidth',0.5,'Color','b');
axis equal
hold off

%METHODOS ROPWN

F0=1; %Ö0=1volt
N=100;
Dx=2*L/N;
A = zeros(N,N);
a=0.0025;
Ri2i=2*h; %Ri'i
one=ones(1,N);
e0=8.854e-12;
e1=e0;
e2=5*e0;
Q=e0;

%TABLE A CALCULATION
for xi=1:N
    for xj=1:N
      Rji=abs(xj-xi)*Dx
      Rj2i=((abs(xj-xi)*Dx)^2 + 4*h^2)^(1/2) %Rj'i
        if (xi==xj)
           A(xi,xj)=1/(4*pi*e1)*(log(((Dx/2+(a^2+(Dx/2)^2)^(1/2))/(-Dx/2+(a^2+(Dx/2)^2)^(1/2)))+(e1-e2)/(e1+e2)*Dx/Ri2i));
           continue
        end
        A(xi,xj)=(Dx/(4*pi*e1))*(1/Rji+(e1-e2)/(e1+e2)*1/Rj2i);
    end
end

A_inv=inv(A); %INVERT TABLE OF A
l0=one*A_inv*F0; %ë0

l=((Q/(sum(l0)*Dx))*F0).*one*A_inv; %ë
l=l./e0; 

x2=[-0.5:1/(N-1):0.5]%vector X for X-AXIS

nfig=1+nfig;
figure(nfig)
plot(x2,l);


F_x=zeros(1,N); %Öx
x3=-2:4/(N-1):2; %axis of Öx for plotting
for ix=1:N;
   x=x3(ix)
     for j=1:N;
         F_x(ix)=F_x(ix)+l0(j)*Dx*2/(4*pi*(e1+e2)*((x-((j-(N/2))*Dx-Dx/2))^2+h^2)^(1/2));
     end
end

nfig=1+nfig
figure(nfig)
plot(x3,F_x); 
