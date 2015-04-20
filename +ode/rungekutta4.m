function [t y]=rungekutta4(f,t,y0)

  h = t(2)-t(1);
  y=zeros(length(y0), length(t));
  y(:,1)=y0;
  for i=1:length(t)-1
    d1 = h*feval(f,t(i),y(:,i));
    d2 = h*feval(f,t(i)+1/2*h,y(:,i)+1/2*h*d1);
    d3 = h*feval(f,t(i)+1/2*h,y(:,i)+1/2*h*d2);
    d4 = h*feval(f,t(i)+h,y(:,i)+h*d3);
    dy=(d1 + 2*d2 + 2*d3 + d4)/6; % q avanzado para adelante
    y(:,i+1)=y(:,i)+dy;
  end

end
