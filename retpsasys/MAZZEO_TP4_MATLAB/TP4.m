%TP4 Gianni F. Mazzeo T.

t=0:0.01:10; %defino paso temporal

%funciones para convulcionar:
u1=exp(-2*t).*escalon(t);
u2=escalon(t)-escalon(t-1); 

%convoluciono mediante el algoritmo de convolucion realizado
y=convolucionar(u1,u2);

%convoluciono mediante el algoritmo de matlab
x=conv(u1,u2);

%comparo resultados.
subplot(2,1,1),plot(y);
subplot(2,1,2),plot(x);