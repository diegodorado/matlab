function [y t]=euler(funcion, ci, ti,tf,h)

t=ti:h:tf-h;
y=zeros(length(ci), length(t));
y(:,1)=ci;
for i=1:length(t)-1
    dy=feval(funcion, t(:,i),y(i));
    y(:,i+1)= y(:,i)+ h*dy; 
end

end