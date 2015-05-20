set(0,'defaultlinelinewidth',1);

beep off
clf
hold off

[d,sr] = audioread('/Users/diegodorado/proyectos/matlab/samples/get-lucky.wav',[1,44100]);
signal = d(:,1);

[d,sr] = audioread('/Users/diegodorado/proyectos/matlab/samples/get-lucky-carrier.wav',[1,44100]);
carrier = d(:,1);

signal_fft = fft(signal);
carrier_fft = fft(carrier);

signal_fft_abs = abs(signal_fft);
signal_fft_angle = angle(signal_fft);

carrier_fft_abs = abs(carrier_fft);

signal_fft = signal_fft .* carrier_fft_abs;


z = signal_fft.*exp(i*signal_fft_angle);

synth = real(ifft(z));
    

%sound(signal,sr);
%sound(carrier,sr);
sound(synth,sr);
