#Set my values as given
a=10;
b=5;
d=3;
L=3; 
D= 2.5;
U=1;
Theta = 1; #Theta = L/d =1

#create my linspaces
y=-15;
Y=15; 
z=-15;
Z=15;
Dy=(Y-y)/400;
Dz=(Z-z)/400;
y1=y:Dy:Y; 
z1=z:Dz:Z; 
[Y,Z] = meshgrid(y1,z1);
Fdynamic = zeros(length(y1),length(z1));
  

#erwthma γ
#We create Φ
for i = 1:length(y1)
    for j = 1:length(z1)
        tempy=Y(i,j);
        tempz=Z(i,j);
        [func] = Fieldfunction(tempy,tempz,a,d,D,b,Theta);
        Fdynamic(i,j) = func; 
    end 
end 

# surface
figure(U) 
hold off 
surface(Y,Z,Fdynamic), shading interp
xlabel('y axis');
ylabel('z axis');
title(' Γραφική απεικόνιση του ηλεκτροστατικού δυναμικού');
hold on

#contour
#take the values there were given
values=[0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1.0 1.05 1.10 1.25 2 3 5];
U=U+1;
figure(U);
hold off
[C,H] = contour(Y,Z,Fdynamic,values,'Linewidth',1);
clabel(C,H,values); # this is for labels
xlabel('y axis');
ylabel('z axis');
title('Ισοδυναμικές επιφάνειες');
axis equal

#quiver
[Fieldx_help, Fieldy_help] = gradient(Fdynamic,Dy,Dz);
Fieldx = - Fieldx_help;
Fieldy = - Fieldy_help;

U = U+ 1;
figure(U)
hold off

Result = ((Fieldx).^2 + (Fieldy).^2).^(1/2);
quiver(Y,Z,Fieldx./Result,Fieldy./Result,0.5); 
xlabel('y axis');
ylabel('z axis');
title('απεικόνιση του ηλεκτρικού πεδίου στο επίπεδο yz');
hold on

