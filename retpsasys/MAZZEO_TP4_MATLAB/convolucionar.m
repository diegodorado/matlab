
function y=convolucionar(u,v)

N=length(u);
M=length(v);

if(M<N)
    h=u;x=v;
else
    h=v;x=u;
end

x(M+N-1)=0;
h(M+N-1)=0;
for(i=1:M+N-1)
y(i)=0;
    for(j=0:i-1)
     y(i)=y(i)+x(i-j)*h(j+1);
end

end

