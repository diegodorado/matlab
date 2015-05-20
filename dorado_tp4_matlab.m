
set(0,'defaultlinelinewidth',2);

fprintf('\n');
fprintf('---------------- \n');
fprintf('CLASE 6 - CONVOLUCION CONTINUA Y DISCRETA \n');
fprintf('---------------- \n');
fprintf('\n');
fprintf('Ejercicio: Desarrollar el algoritmo de convolucion discreta en MatLab. \n');
fprintf('Simular,utilizando un paso temporal de 0.01s, la siguiente convolucion continua: \n');
fprintf(' exp(-2t)u(t) * [u(t)-u(t-1)] \n');
fprintf('Verificar los resultados con el comando conv de matlab.\n');
fprintf('\n');


t1 = -1:0.1:5;
t2 = 0:0.1:3;
x1 = exp(-2*t1).*ideal.escalon(t1);;
x2 = ideal.escalon(t2) - ideal.escalon(t2-2);;

conv.plot_conv(t1,x1,t2,x2);