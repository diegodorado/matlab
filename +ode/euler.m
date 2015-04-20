function [t y]=euler(f, t, y0)

  h = t(2)-t(1);
  y=zeros(length(y0), length(t));
  y(:,1)=y0;
  for i=1:length(t)-1
      dy=feval(f, t(:,i),y(i));
      y(:,i+1)= y(:,i)+ h*dy; 
  end

end