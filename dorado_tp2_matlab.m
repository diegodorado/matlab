
clearvars
clf
hold on

fprintf('\n');
fprintf('---------------- \n');
fprintf('CLASE 3 - DERIVACION E INTEGRACION NUMERICA\n');
fprintf('---------------- \n');
fprintf('Ejercicio 1: \n');
fprintf('Implementar en MatLab la resolucion por el metodo de Euler de una EDO de 1er orden. \n');
fprintf('Comparar el resultado obtenido aplicando el metodo de Runge Kutta de 4to orden, \n');
fprintf('provisto en el campus virtual.\n');
fprintf('---------------- \n');
fprintf('\n');



% Condiciones de Integracion
y0=0; % Condicion Inicial de la ecuacion
ti=0; % tiempo inicial de simulacion
tf=10; % tiempo final de simulacion
N=1000; % cantidad de pasos
h=(tf-ti)/N; %paso temporal a utilizar
t=ti:h:tf-h;

% Solucion Analitica
ya=exp(-2*t)-exp(-3*t);

fprintf('dy+3y=e(-2t) \n');
fprintf('dy=e(-2t)-3y \n');
fprintf('Declarado como funcion anonima \n');
f = @(t,y) exp(-2*t)-3*y; %aca t es el argumento de la f anonima, y no la variable t local

% Soluciones Aproximadas por distintos metodos
[t1,sol1]= ode.euler(f,t ,y0);
%[t2,sol2]=ode.rungekutta4(f,t, y0);
[t2,sol2]= ode.euler(f,t ,y0);
[t3,sol3]=ode23(f,t,y0);


subplot(221);plot(t1,sol1,t2,sol2,t3,sol3,t,ya, 'LineWidth',2);
legend('euler', 'runge', 'ode23','anali');
grid;



subplot(223);plot(t1,abs(sol1-ya),t2,abs(sol2-ya),t3,abs(sol3'-ya), 'LineWidth',2);
legend('euler', 'runge', 'ode23');
ylabel('Error absoluto');
grid;

fprintf('\n');
fprintf('---------------- \n');
fprintf('Ejercicio 2: \n');
fprintf('Implementar en MatLab la resolucion de la siguiente EDO de 2do orden aplicando \n');
fprintf('el metodo de Runge Kutta de 4to orden:\n');
fprintf('a*d2y + b*dy + c*y = f(t) \n');
fprintf('Verifique con los resultados obtenidos en el TP2 de Simulink\n');
fprintf('---------------- \n');
fprintf('\n');



fprintf('Planteamos una EDO de 2do orden: a*d2y + b*dy + c*y = f(t) \n');
fprintf('Con f(t) = 5t^4 + 3t^2 - t \n');
ft = @(t) 5*t^4 + 3*t^2 - t; % t es el argumento de la f anonima, y no la variable t local
fprintf('Definimos valores para a,b y c \n');
a=1;b=2;c=4;

fprintf('Entonces: a*d2y + b*dy + c*y = f(t) \n');
fprintf(' con: u = dy \n');
fprintf('  --> a*du + b*u + c*y = f(t) \n');
fprintf('  --> dy = u  \n');
fprintf('  --> du = [f(t) - b*u - c*y]/a  \n');

fprintf('Y definimos una funcion anonima que devuelva la matriz de EDO \n');
f = @(t,z) [z(2) ; (ft(t) - b*z(2) - c*z(1))/a ]; % z(1): y , z(2): u

fprintf('Buscamos la solucion aproximada por el metodo Runge Kutta \n');
[t1,sol]=ode.rungekutta4(f,t,[0 0]);

fprintf('Buscamos la solucion analitica con DSOLVE \n');
syms y(ts)
Dy = diff(y);
sol_a = dsolve(a*diff(y, 2) + b * diff(y) + c * y == ft(ts), y(0) == 0, Dy(0) == 0);
y_a = (subs(sol_a,t));

subplot(222);
plot(t1,sol(1,:), t, y_a, 'LineWidth',2);
legend('RungeKutta', 'DSOLVE');
grid;

subplot(224);
plot(t,abs(sol(1,:) - y_a), 'LineWidth',2);
legend('RungeKutta');
grid;
ylabel('Error absoluto');


