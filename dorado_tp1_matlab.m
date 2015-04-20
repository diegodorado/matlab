fprintf('\n');
fprintf('---------------- \n');
fprintf('Ejercicio 1.1 \n');
fprintf('---------------- \n');
fprintf('\n');

clf
hold on

figure(1)

fprintf('Ploteo de 5 funciones en FIGURA 1 \n');
fprintf('Ts = 0.01; de 0 a 5 \n');

t = 0:0.01:5;
term1 = 2 * rampa(t);
term2 = -2 * rampa(t-2) ;
term3 = -2 * escalon(t-2);
term4 = -3 * delta(t-4);

subplot (5, 1, 1)
plot(t,term1,'r');
title('Ejercicio 1.1')
ylabel('Amplitud')
ylim([-10,10]);
legend('2 * rampa(t)');

subplot (5, 1, 2)
plot(t,term2,'b');
ylabel('Amplitud')
ylim([-10,10]);
legend('-2 * rampa(t-2)');

subplot (5, 1, 3)
plot(t,term3),'m';
ylabel('Amplitud')
ylim([-10,10]);
legend('-2 * escalon(t-2)');

subplot (5, 1, 4)
plot(t,term4,'g');
ylabel('Amplitud')
ylim([-10,10]);
legend('-3 * delta(t-4)');


subplot (5, 1, 5)
plot(t,term1 + term2 + term3 + term4,'r');
xlabel('Tiempo')
ylabel('Amplitud')
ylim([-10,10]);
legend('resultado');


fprintf('\n');
fprintf('---------------- \n');
fprintf('Ejercicio 1.2 \n');
fprintf('---------------- \n');
fprintf('\n');


% seno de 10Hz con fase pi/4
% f1(t) =     C    +     A     * seno(           w0        * t +  fi  )
%         constante   amplitud          frecuencia angular       fase
%             0           1                     2*pi*10Hz         pi/4

fprintf('Ploteo en  FIGURA 2 \n');
fprintf('primeras 100 muestras, en forma discretizada y normalizada \n');
fprintf('Ts = 0.01; de 0 a 0.5 \n');
t = 0:0.01:0.5;


figure(2)

subplot (3, 2, 1)
f1 = sin( 10*t + pi/4);
plot(t,f1);
title('sin( 10*t + pi/4)')
subplot (3, 2, 2)
stem(f1);
title('sin( 10*t + pi/4)  - normalizado')

subplot (3, 2, 3)
f2 = sin( 100*t + pi/4);
plot(t,f2);
title('sin( 100*t + pi/4)')
subplot (3, 2, 4)
stem(f2);
title('sin( 100*t + pi/4)  - normalizado')

fprintf('Cambiando el paso a Ts = 0.001; de 0 a 0.05 \n');
t = 0:0.001:0.05;


subplot (3, 2, 5)
f2 = sin( 100*t + pi/4);
plot(t,f2);
title('sin( 100*t + pi/4)')
subplot (3, 2, 6)
stem(f2);
title('sin( 100*t + pi/4)  - normalizado')


fprintf('\n');
fprintf('Segun el calculo de la frecuencia normalizada, para un Ts = 0.01 y una frecuencia f0=100Hz:\n');
fprintf('frecuencia normalizada = 2*PI*f0*Ts = (2*PI*100*0.01) Hz ?= 6.28Hz < 7 ;\n');
fprintf('es decir, que para cada ciclo, se veran menos de 7 puntos. Es por eso que el grafico no deja percibir la onda\n');
fprintf('Al afinar el paso, aumenta la frecuencia normalizada y se muestran en este caso alrededor de 62 puntos por periodo.\n');




fprintf('\n');
fprintf('---------------- \n');
fprintf('Ejercicio 1.3 \n');
fprintf('---------------- \n');
fprintf('\n');

fprintf('Ploteo en  FIGURA 3 \n');


n = -10:1:10;


figure(3)

subplot (3, 1, 1)
f1 = cos( (pi/4)*n);
stem(n,f1);
title('cos( (pi/4)*n)')

subplot (3, 1, 2)
f2 = cos( pi*n);
stem(n,f2);
title('cos( pi*n)')

subplot (3, 1, 3)
f3 = cos( 9*(pi/4)*n);
stem(n,f3);
title('cos( 9*(pi/4)*n)')

fprintf('cos( (pi/4)*n) y cos( 9*(pi/4)*n) muestran el mismo grafico porque se trata de la misma funcion: \n');
fprintf('cos( 9*(pi/4)*n) = cos( 2*pi*n + (pi/4)*n) = cos( (pi/4)*n), por ser n Natural y coseno periodica cada 2*pi \n');

