

% obtenemos el valor seleccionado en el popupmenu1
opcion = 1;
%Frecuencia de muestreo
Fs = 44100;
%Variacion de t
dt=1/Fs;   

should_record=0;

if should_record==1
  %Grabamos el archivo de sonido, usando la funcion  audiorecorder(Fs, NBITS, numero de canales)   
  r = audiorecorder(Fs, 16, 1);
  record(r);
  %El archivbo de sonido durar? 3 s.    
  pause(3)
  pause(r);
  %Obtenemos los datos de la grabacion de audio r     
  y = getaudiodata(r);
  %Guardamos el archivo de sonido en formato wav.
  wavwrite(y,Fs,'nota');
end

%Leemos el archivo .wav
[y,fs]= wavread('nota');
%Sabemos que t=n/f, entonces calculamos el tiempo.
T=length(y)/fs;
%Creamos un vector tiempo n=tiempo*fs
t=linspace(0,T,T*fs);
%axes(handles.axes1)

subplot(311);
plot(t,y)
xlabel('Tiempo')
ylabel('f(t)')
%Aplicamos la transformada de fourier para obtener la frecuencia de la
%se?al
g=fft(y);
%Calculamos la potencia espectral, de la se?al g, para poder obtener la
%frecuencia predominante de la se?al
potencia=abs(g).^2;
%Calculamos el tama?os de cada intervalo de frecuencia
df=1/(length(y)*dt);
%Realizamos el vector frecuencia
f=(0:length(y)-1)*df;
%Obtenemos el valor y posicion maximo de la potencia espectral, siendo k la
%posicion de este elemento
[r,k]=max(potencia);
%Obtenemos el valor de frecuencia que corresponde a la posicion de la
%frecuencia maxima.
fn=f(k)
%axes(handles.axes2)
%Graficamos la potencia en funcion de la frecuencia
subplot(312);

plot(f,potencia)
xlabel('Frecuencia')
ylabel('Potencia espectral')
j=linspace(0,5);

%Calculamos el error relativo
e=(fn-659.255)*100/659.255;
%Enviamos al valor del error al edit1
%set(handles.edit1,'string',e);
%Sabemos que la frecuencia que corresponde a MI4 es 659.255 Hz
%Realizamos una comparacion grafica de las frecuencias
subplot(313);

plot(j, 659.255, 'r')
hold on
plot(j,fn, 'g')
