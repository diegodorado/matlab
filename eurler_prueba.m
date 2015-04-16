




%Dy+3y=e(-2t)

% Solucion
%y= e(-2t)-e(-3t)
%% Condiciones de Integracion
y0=0; % Condicion Inicial de la ecuacion
ti=0; % tiempo inicial de simulacion
tf=10; % tiempo final de simulacion
N=1000; % cantidad de pasos
h=(tf-ti)/N; %paso temporal a utilizar
t=ti:h:tf-h;
%% Solucion Analitica si existe para comparar
ya=exp(-2*t)-exp(-3*t);

%% Soluciones Aproximadas por distintos metodos
[sol1,tt1]=euler(@f_test,y0, ti, tf,h);
[sol2,tt2]=rungekutta4(@f_test,y0, ti, tf,h);
[tt3,sol3]=ode23(@f_test,ti:h:tf-h,y0);

figure;
subplot(211);plot(tt1,sol1,'.',tt2,sol2,'o',tt3,sol3,'-.',t,ya);
legend('euler', 'runge', 'ode23','anali');

subplot(212);plot(tt1,abs(sol1-ya),'.',tt2,abs(sol2-ya),'o',tt3,abs(sol3'-ya));
legend('euler', 'runge', 'ode23');





    
