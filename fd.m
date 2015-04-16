

%funcion dx
function dy=fd(t,y)
%% Constantes
% dy=zeros(2,1);
% J=1;
% B=168;
% K=14.4*10^3;
% fx=288*10^3;
%%  Ecuacion
% dy(1)=y(2); % u=y*
% dy(2)=fx-B*y(2)-K*y(1); % u*=y**
% dy(2)=dy(2)/J;

%%
dy=exp(-2*t)-3*y;
%%
% xn=escalon(t);
% dy=-1*y+10*xn;
% dy=y+t;
% j1=1;
% j2=2;
% j3=3;
% j4=4;
% D1=5;
% D2=6;
% eta=2;
% a=j1+j2+(j3+j4)/eta^2; %
% b=D1+D2/eta^2; %
% 
% 
% dy=delta(t)-b*y/a;


end
%% 1 168 14.4 10^3 = f(x)
%% modelo poisson 2 orden con tita (posicio, torque, angulo)
%% modelo wind kessel . bomba de bombero RC
%% dv/dt+q2'=0;
%% c*dp/dt+p/R2=0
%p=Aexp(-st)
%p0=Aexp(-t/R2C)

