function frame = burst_2_frame( burst, prevFrame )

%   22.11.04, pm-n.
%
%   'prevFrame' is optional. frame.freq is only calculated if 'prevFrame'
%   is available.

globals;

firstfft = WINDOW_OFFSET;
lastfft  = firstfft + NW - 1;

paddedframe = zeros( NS, 1 );
paddedframe(firstfft:lastfft) = BURST_WINDOW .* burst.buffer;

fftframe = fft( paddedframe );

frame.first = burst.first;

frame.amp = abs( fftframe(1:SPECTRUM_SIZE) );
frame.amp(1) = real( fftframe(1) );
frame.amp(SPECTRUM_SIZE) = real( fftframe(SPECTRUM_SIZE) );

frame.phase = angle( fftframe(1:SPECTRUM_SIZE) );
frame.phase(1) = 0;
frame.phase(SPECTRUM_SIZE) = 0;

if nargin == 2

  if burst.first == prevFrame.first
   frame.freq = prevFrame.freq;
  else
   frame.freq = frame.phase - prevFrame.phase;
   incrT = abs( burst.first - prevFrame.first )/FS;
   freqk = floor( ( [0:SPECTRUM_SIZE-1]' * FS / NS * incrT ) - ...
                   frame.freq / pi / 2.0 +  0.5 );
   frame.freq = frame.freq / pi / 2.0 / incrT + freqk / incrT;
  end;

else

  frame.freq = [];

end;

