function [ y ] = delta( t )
%Accion: Genera la funcion impulso: d(t)= 1/dt si t=0, 0 si t<>0
%Entrada: t-> vector temporal (t) o discreto (n)
%Salida: y-> vector temporal d(t) o discreto d(n)
  if(length(t)==1)
      dt=1;
  else
  dt=abs(t(2)-t(1));
  end
  y=(1/dt).*(t<dt).*(t>-dt);
end
