%Given 
a=1; 
M0=1;
m0=4*pi*10^-7;

X=6*a/50;
Y=6*a/50;
xa=-3*a:X:3*a;
ya=-3*a:Y:3*a;
[X,Y]=meshgrid(xa,ya);

for i=1:length(xa)
    for j=1:length(ya)
        x=X(i,j);
        y=Y(i,j);
        [TH,R,Z]=cart2pol(x,y,1);
        A(i,j)=-a*integral(@(phi2) fun(phi2,a,R,TH),0,2*pi);
    end
end

th=0:2*pi/50:2*pi;
xc=a*cos(th);
yc=a*sin(th);

% surface
figure(1)
surface(X,Y,A); 
hold on 
shading interp
colorbar
axis equal
title('Magnetic Field')
xlabel('x')
ylabel('y')

%contour
figure(2)
cont=2.7*[-0.9:0.1:0.9]
[Conhelp,H]=contour(X,Y,A,cont,'LineWidth',1);
axis equal
hold on
plot(xc,yc,'LineWidth',2,'Color','k')
title('Magnetic Field contour')
xlabel('x')
ylabel('y')

%d erwthma
for i=1:length(xa)
    for j=1:length(ya)
        x=X(i,j);
        y=Y(i,j);
        [TH,R,Z]=cart2pol(x,y,1); 
        Fieldx(i,j)=(m0*M0/(2*pi))*a*integral(@(phi2) dhelpx(phi2,a,R,TH,y),0,2*pi);
        Fieldy(i,j)=-(m0*M0/(2*pi))*a*integral(@(phi2) dhelpy(phi2,a,R,TH,x),0,2*pi);
        if (R>a)
            Hx(i,j)=Fieldx(i,j)/m0;
            Hy(i,j)=Fieldy(i,j)/m0;
        else Hx(i,j)=Fieldx(i,j)/m0;
            Hy(i,j)=Fieldy(i,j)/m0-M0;
        end
    end
end

%quiver
figure(3)
RR=sqrt(Fieldx.^2+Fieldy.^2);
q=quiver(X,Y,Fieldx./RR,Fieldy./RR,0.5);
axis equal
hold on
plot (xc,yc,'LineWidth',2,'Color','k')
title('B(x,y)')
xlabel('x')
ylabel('y')
hold off

%2nd quiver
figure(4)
RR=sqrt(Hx.^2+Hy.^2);
q=quiver(X,Y,Hx./RR,Hy./RR,0.5);
axis equal
hold on
plot (xc,yc,'LineWidth',2,'Color','k')
title('H(x,y)')
xlabel('x')
ylabel('y')
hold off
