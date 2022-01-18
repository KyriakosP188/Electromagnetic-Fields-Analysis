 a=0.1;
 d=1; 
 h=1;
 U=1;                      

#set my linspace
[X,Y] = meshgrid(linspace(0,2,100));

#4 integrals for every q and then add them to find Dynamic
D_1=a*integral(@(phi)1./Resitance(X,Y,d,h,a,phi,1),0,2*pi,'ArrayValued',true);
D_2=-a*integral(@(phi)1./Resitance(X,Y,d,-h,a,phi,1),0,2*pi,'ArrayValued',true);
D_3=a*integral(@(phi)1./Resitance(X,Y,-d,-h,a,phi,1),0,2*pi,'ArrayValued',true);
D_4=-a*integral(@(phi)1./Resitance(X,Y,-d,h,a,phi,1),0,2*pi,'ArrayValued',true);
D = D_1+D_2+D_3+D_4;

#prinf surface
hold off
figure(U)
surface(X,Y,D,'LineStyle','None');
xlabel('x axis');
ylabel('y axis');
title('Normalized dynamic Ö');
hold on

#print contour
U=U+1; 
figure(U) 
#given values
cont = [0.01 0.1 0.2 0.4 0.8 1.0 1.5 2 2.5 3 3.5 4 5 6 7.5];
[C,H] = contour(X,Y,D,cont,'Linewidth',1); 
xlabel('x axis');
ylabel('y axis');
title('Normalized dynamic Ö');
hold on; 
clabel(C,H,cont);  #this is for labels in figure 2
hold on 

#print quiver
[Fieldx_help,Fieldy_help]=gradient(D,0.01,0.01);
Fieldx = - Fieldx_help;
Fieldy = - Fieldy_help;

U = U + 1;          #inc U
figure(U)
hold off
Result = ((Fieldx).^2 + (Fieldy).^2).^(1/2);

quiver(X,Y,Fieldx./Result,Fieldy./Result,0.5) 
xlabel('x axis');
ylabel('y axis');
title('Electrical field');


