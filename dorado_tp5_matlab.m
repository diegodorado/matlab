%Punto 1.1---------------------------------------------------------
z1=1+2i %Numero complejo fma cartesiana
z2=2*exp(-i*pi/4) %Numero complejo fma polar
abs(z1),angle(z1) %M?dulo y fase
real(z2),imag(z2) %Parte Real e Imaginaria
%Punto 1.2---------------------------------------------------------
z3=z1+z2 %Suma en complejos
z4=z1-z2 %Resta en complejos
z5=z1*z2 %Producto en complejos
z6=z2/z1 %Cociente en complejos
z7=(z1)^3 ; %Potenciaci?n en complejos
z8=roots([1 0 0 0 (-1)*z2]) %Radicaci?n en complejos
%Punto 1.3---------------------------------------------------------
figure(1),compass([z1 z2 z3]) %Visualizaci?n gr?fica
title('z1,z2,z1+z2') %z1,z2,z1+z2
figure(2),compass(z8) %
title('Raiz cuarta z2') %4 Raices de z2