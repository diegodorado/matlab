%% se usa convgrafica(señal1, señal2, plot o stem)
function y=convgrafica(u,v,func)

N=length(u);
M=length(v);

y=zeros(1,M+N-1);
L=M+N-1;
L2=floor(L/2);

if(M<N)
    h=v;x=u;
else
    h=u;x=v;
end
N=length(x);
M=length(h);
%N --> x es el del mayor
%M --> h es el del menor
%% relleno con ceros
t2=-ceil((L)/2):L2-1;
h2=[h zeros(1,N-1)];
x2=[x zeros(1,M-1)];

h2=circshift(h2, [0,L2]);
x2=circshift(x2, [0,L2-1]);
x2=fliplr(x2);
subplot(311);func(y,'LineWidth', 3)
subplot(312);func(t2,h2, '*-','LineWidth', 3);hold on;func(t2,-x2,'r.-','LineWidth', 3);hold off;
% pause;
% x2=circshift(x2, [0 1]);   
for i=1:M+N-1
   if i<=M
    for(j=0:i-1)
     y(i)=y(i)+x(i-j)*h(j+1);
    end
   elseif(i<=N)
    for(j=0:M-1)
     y(i)=y(i)+x(i-j)*h(j+1);
    end
   else    
     for(j=i-N:M-1)
     y(i)=y(i)+x(i-j)*h(j+1);
     end
   end


subplot(311);func(y,'LineWidth', 2)
subplot(312);func(t2,h2, '*-','LineWidth', 2);hold on;func(t2,-x2,'r.-','LineWidth', 2);hold off;
% ui2=2*(escalon(i-(t2+2))-escalon(i-(t2+8)));
x2=circshift(x2, [0 1]);   
pause
%axis([-2 21 0 4]);    
end


end