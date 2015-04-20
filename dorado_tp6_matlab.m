fprintf('\n');
fprintf('---------------- \n');
fprintf('CLASE 9 – MAPEO CONFORME \n');
fprintf('---------------- \n');
fprintf('Mapear el recinto (y=1, y=x, y=-x) a través de la funciones z^2 y 1/z \n');
fprintf('\n');

clf
hold on


x_min=-100;
x_max=100;
dx=0.01;
x=x_min:dx:x_max;

%Plano Z (ORIGEN)

%Z1: Recta y=x
y=x;
z1=complex(x,y);
%Z2: Recta y=-x
y=-x;
z2=complex(x,y);
%Z3: Recta y=1
y=1;
z3=complex(x,y);
%ZP: Punto de control
zP=2i/3;

%intersecciones
z1_z3 = 1 + i;
z3_z2 = -1 + i;
z2_z1 = 0;



figure(1)


subplot (1, 3, 1);
hold on;
plot(z1,'b');
plot(z2,'r')
plot(z3,'m')
legend('y=x','y=-x','y=1');
plot(real(zP), imag(zP),'o','markersize',5);
plot(real(z1_z3), imag(z1_z3),'*b','markersize',5);
plot(real(z3_z2), imag(z3_z2),'*m','markersize',5);
plot(real(z2_z1), imag(z2_z1),'*r','markersize',5);

xlabel('x'),ylabel('jy');
title('PLANO ORIGEN');
xmin=-4;xmax=-xmin;ymin=-4;ymax=-xmin;
axis([xmin xmax ymin ymax]);
grid on;




subplot (1, 3, 2)
hold on;
plot(z1.^2,'b');
plot(z2.^2,'r')
plot(z3.^2,'m')
legend('y=x','y=-x','y=1');
wP=zP^2;
plot(real(wP), imag(wP),'o','markersize',5);
plot(real(z1_z3^2), imag(z1_z3^2),'*b','markersize',5);
plot(real(z3_z2^2), imag(z3_z2^2),'*m','markersize',5);
plot(real(z2_z1^2), imag(z2_z1^2),'*r','markersize',5);

xlabel('x'),ylabel('jy');
title('PLANO DESTINO: f(z) = z^2');
xmin=-4;xmax=-xmin;ymin=-4;ymax=-xmin;
axis([xmin xmax ymin ymax]);
grid on;


subplot (1, 3, 3)
hold on;
plot(1./z1,'b');
plot(1./z2,'r')
plot(1./z3,'m')
legend('y=x','y=-x','y=1');
wP=1./zP;
plot(real(wP), imag(wP),'o','markersize',5);
plot(real(1./z1_z3), imag(1./z1_z3),'*b','markersize',5);
plot(real(1./z3_z2), imag(1./z3_z2),'*m','markersize',5);
%plot(real(1./z2_z1), imag(1./z2_z1),'*r','markersize',5);

xlabel('x'),ylabel('jy');
title('PLANO DESTINO: f(z) = 1/z');
xmin=-4;xmax=-xmin;ymin=-4;ymax=-xmin;
axis([xmin xmax ymin ymax]);
grid on;
