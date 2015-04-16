function r=rampa(t)
%Rampa: r(t)= t si t>0; 0 si t<=0
%Entrada: vector temporal (t) o discreto (n)
%Salida: vector temporal r(t) o discreto r(n)
  r=t.*(t>0);
end