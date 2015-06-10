set(0,'defaultlinelinewidth',1);

fprintf('\n');
fprintf('---------------- \n');
fprintf('---------------- \n');
fprintf('\n');

beep off
clf
hold off




b = uicontrol('style','push','string','PANIC','callback','return');



FrameSize = 1024;
FPS = 30;
AFR = dsp.AudioFileReader('Filename','/Users/diegodorado/proyectos/matlab/samples/get-lucky-carrier.wav',...
    'SamplesPerFrame',FrameSize);
Fs = AFR.SampleRate;
AP = dsp.AudioPlayer('SampleRate',Fs, 'OutputNumUnderrunSamples',true);

ymin = 0;
ymax = 0;

y2max = 0;


k1 = 0;
k2=0;
while ~isDone(AFR)
  audio = step(AFR);
  left=audio(:,1); % Left channel 


  t = 0:FrameSize-1;

  ymin = min(ymin,min(left));
  ymax = max(ymax,max(left));
  y2max = ymax;

  y = fft(left);
  abs_y = abs(y);    
  angle_y = angle(y);    
  y2max = max(y2max,max(abs_y));

  synth_abs_y = zeros(length(abs_y),1);
  [ pks,idx]=findpeaks(abs_y,'SortStr','descend','NPeaks',1);
  synth_abs_y(idx) = pks;
  angle_y(1:512) = -fliplr(angle_y(513:1024));
  y2 = synth_abs_y .* exp(i*angle_y);

  %synth = real(ifft(synth_abs_y));
  synth = real(ifft(y2));
    

  
  
  
  %nUnderrun = step(AP,left);
  nUnderrun = step(AP,synth);
  
  % no hace falta graficar en todos los pasos...
  if k2==64
    k2 = 0;

    subplot(411);
    plot(t,left);
    xlim([0, FrameSize-1])
    ylim([ymin, ymax]);

    subplot(423);
    plot(abs_y(1:50));
    ylim([0, y2max]);

    subplot(424);
    plot(angle_y(1:50));
    ylim([-pi, pi])

    subplot(425);
    plot(synth_abs_y(1:50));
    ylim([0, y2max]);

    subplot(426);
    plot(angle_y(1:50));
    ylim([-pi, pi]);
    
    subplot(414);
    plot(synth);
    ylim([ymin, ymax]);
    
    
    drawnow;    
    
  end
  k2 =  k2 + 1;
  
  
  
  if nUnderrun > 0
    fprintf('Audio player queue underrun by %d samples.\n'...
	     ,nUnderrun);
  end
  
end


pause(AP.QueueDuration); % wait until audio is played to the end
release(AFR);            % close the input file
release(AP);             % close the audio output device

return


t = 0:0.02:1;
x = 0.5 - square(t*2*pi)';
y = fft(x);


subplot(311);
plot(t,x);
subplot(323);
stem(abs(y));
subplot(324);
plot(angle(y));

%return



[d,sr] = wavread('/Users/diegodorado/proyectos/matlab/samples/audio.wav');


x1 = d;
t = (0:length(d)-1)/sr;
t(length(d))
x2 = 0.3*sawtooth(440*t*2*pi)';


y1 = fft(x1);
y2 = fft(x2);

length(angle(y1))
length(angle(y2))


y3 =  complex( abs(y1).*abs(y2) , angle(y1).*angle(y2) );

x3 = ifft(y3);

%sound(x1,sr);
%sound(x2,sr);
%sound(x3,sr);


%subplot(211);
%plot(t,x1,t,x2,t,x3);
%legend('x1','x2','x3');
%subplot(223);
%plot(abs(y2));
%subplot(224);
%plot(angle(y2));




%sound(x1,44100);
%sound(x2,44100);
%sound(x3,44100);

