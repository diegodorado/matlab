%% ODE Variables
clear all
orden=1;
switch(orden)
    case 2;
% %% Segundo Orden OJO armentano
% a=1;
% b=168;
% c=14400;
% 
% t=0:100;
% fx=10*escalon(t);
% fx2=[t' fx'];
% 
%% Segundo Orden Sistema RLC

a=1;     %
b=168;   %
c=14400; %

t=0:100;
fx=10*escalon(t);
fx2=[t' fx'];

% % la salida del sistema es time y fy2
    case 1;
%% Primer Orden
%Sistema con engranajes
j1=0.01;
j2=0.02;
j3=0.03;
j4=0.04;
D1=5;
D2=6;
eta=2;
a=j1+j2+(j3+j4)/eta^2; %
b=D1+D2/eta^2; %

CI1=0;
t=0:1000;
A=1;
% fx=A*escalon(t);

fx=zeros(size(t));
fx(1:10)=A;
fx(100:110)=A;

fx1=[t' fx'];

% la salida del sistema es time y fy1
end



