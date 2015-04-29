
clearvars
clf
hold on
set(0,'defaultlinelinewidth',2);

fprintf('\n');
fprintf('---------------- \n');
fprintf('CLASE 4: SIMULACION - EDOs  \n');
fprintf('---------------- \n');
fprintf('Ejercicio: \n');
fprintf('Realice los siguientes diagramas en simulink: \n');
fprintf('\n');
fprintf('a*d2y/dt + b*dy/dt + c*y = f(t) \n');
fprintf('\n');
fprintf('1.1) Utilizando f (t) = 0 . Analice las distintas soluciones posibles.\n');
fprintf('\n');
fprintf('Planteamos la ecuacion caracteristica:\n');
fprintf('y(t) = exp(k*t)  \n');
fprintf('dy/dt = k*exp(k*t)  \n');
fprintf('d2y/dt = k^2*exp(k*t)  \n');
fprintf('a*d2y/dt + b*dy/dt + c*y = a*k^2*exp(k*t) + b*k*exp(k*t) + c*exp(k*t) = 0 \n');
fprintf('a*d2y/dt + b*dy/dt + c*y = exp(k*t) * [ a*k^2 + b*k + c] = 0 \n');
fprintf('a*k^2 + b*k + c = 0 \n');


syms a b c k
sol = solve(a*k^2 + b*k + c == 0, k);
pretty(sol);

fprintf('Las soluciones posibles, dependen de los valores de a, b y c \n');
fprintf('Y pueden dar 3 tipos de soluciones diferentes, segun las raices de la ecuacion caracteristica sean: \n');
fprintf(' 1) reales distintas ( sobreamortiguamiento) \n');
fprintf(' 2) reales dobles ( amortiguamiento critico) \n');
fprintf(' 3) complejas conjugadas ( subamortiguamiento) \n');

fprintf('Veamos un ejemplo de cada caso: \n');
t=0:0.01:10;
syms y(ts)
Dy = diff(y);
y0 = 1; %condiciones iniciales no nulas, para ver la estabilizacion del sistema
Dy0 = 0;

a=1;b=5;c=4;
sol_1 = dsolve(a*diff(y, 2) + b * diff(y) + c * y == 0, y(0) == y0, Dy(0) == Dy0);
y_1 = (subs(sol_1,t));

a=1;b=4;c=4;
sol_2 = dsolve(a*diff(y, 2) + b * diff(y) + c * y == 0, y(0) == y0, Dy(0) == Dy0);
y_2 = (subs(sol_2,t));

a=1;b=1;c=4;
sol_3 = dsolve(a*diff(y, 2) + b * diff(y) + c * y == 0, y(0) == y0, Dy(0) == Dy0);
y_3 = (subs(sol_3,t));




fprintf('1.2) Utilizando la respuesta sub-amortiguada. Siendo f (t) = exp(-3t) + t*exp(-2t) \n');

f = @(t) exp(-3*t) + t*exp(-2*t); % t es el argumento de la f anonima, y no la variable t local
a=1;b=1;c=4;
sol_4 = dsolve(a*diff(y, 2) + b * diff(y) + c * y == f(ts), y(0) == y0, Dy(0) == Dy0);
y_4 = (subs(sol_4,t));

subplot(211);
plot(t,y_1,t,y_2,t,y_3,t,y_4,'g--');
legend('sobreamortiguamiento', 'amortiguamiento critico', 'subamortiguamiento','con f(t)= exp(-3t) + t*exp(-2t)');



fprintf('Utilice como entrada ( t ) el reloj de simulink (sources->lock).\n');
fprintf('1.3) Utilizando la respuesta sobre-amortiguada. Siendo f(t)=cos(pi*t)+ sin(pi/2*t).\n');
fprintf('Utilice como entrada ( t ) el reloj de simulink (sources->lock).\n');
fprintf('1.4) Verifique el funcionamiento de las herramientas SIMIN y SIMOUT. \n');
fprintf('Genere una se?al en matlab y utilicela como entrada en su diagrama en simulink. \n');
fprintf('Finalmente grafique la entrada y la salida del sistema en matlab.\n');

simin = [t;5*sin(pi/2*t)./(t+1)]';

subplot(212);

% una vez ejecutada la simulacion, plotear con el siguiente comando
% plot(simout.Time, simout.Data);
