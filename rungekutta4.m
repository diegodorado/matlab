function [y t]=rungekutta4(funcion, ci, ti,tf,h)

t=ti:h:tf-h;
y=zeros(length(ci), length(t));
y(:,1)=ci;
for i=1:length(t)-1
      d1 = h*feval(funcion,t(i),y(:,i)); 
      d2 = h*feval(funcion,t(i)+1/2*h,y(:,i)+1/2*h*d1);
      d3 = h*feval(funcion,t(i)+1/2*h,y(:,i)+1/2*h*d2);
      d4 = h*feval(funcion,t(i)+h,y(:,i)+h*d3);
      dy=(d1 + 2*d2 + 2*d3 + d4)/6; % q avanzado para adelante
      y(:,i+1)=y(:,i)+dy;
end

end
