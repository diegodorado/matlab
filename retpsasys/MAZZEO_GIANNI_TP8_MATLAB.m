%f(z)=z/(z^2+iz+2) ejercicio 1 guia 4 de complejos
%g(z)=(z^2)/((z-2)^2)*((z^2)+1)) ejercicio 3 guia 4 de complejos

%Calculos de raices del denominador:
roots([1 1i 2]) %Para f(z)
roots(conv([1 -4 4],[1 0 1])) % para g(z)

%-----------------------------------------------------------------------
%Calculo de POLOS Y CEROS DE FUNCIONES RACIONALES
%Coeficientes del polinomio del numerador (completo) Num(z)=z
Numf=[1 0]; %f(z)
%Coeficientes del polinomio del denominador (completo) Den(z)=z^2+iz+2
Denf=[1 1i 2];%f(z)
%Coeficientes del polinomio del numerador (completo) Num(z)=z^2
Numg=[1 0 0];%g(z)
%Coeficientes del polinomio del denominador (completo) Den(z)=((z-2)^2)*((z^2)+1))
Deng=conv([1 -4 4],[1 0 1]);%g(z)
%Función transferencia
H1=tf(Numf,Denf);
H2=tf(Numg,Deng);
%Ceros
zero(H1)
zero(H2)
%Polos
pole(H1)
pole(H2)

%-----------------------------------------------------------------
%OBTENCION DE RESIDUOS
residue(Numf,Denf) %PARA F(z)
residue(Numg,Deng) %PARA G(z)