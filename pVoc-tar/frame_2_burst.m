
function  [ burst, frameRev ] = frame_2_burst( frame, method, prevFrame )

% 22.11.04, pm-n.

% The synthesis of the burst is based on peaks in 'frame.amp'
% identified by findPeaksA  using MAX_PEAK and EPS_PEAK.
% 'prevFrame' is optional.
% 'frameRev' is 'frame' with updated phases.
%
% If method = 0, the pi-rule is used under the peak. 
% If method = 1, the phase shifts under the peak are taken from frame.phase.
% If method = 2, freq at the peak is estimated as a weighted sum
%                    of centerfrequencies under the peak, and then
%                    the pi-rule is used.

globals;

if nargin == 2
  frameRev = frame;
else

  frameRev = frame;

  peaks = findPeaks( frame.amp );  
  [ npeaks, dummy ] = size( peaks );
  
%  Revise 'frameRev.freq':

  if ( method == 2 ) | ( length( frameRev.freq ) == 0 )

     if length( frameRev.freq ) == 0
       frameRev.phase = zeros( length( frameRev.amp ), 1 );
     end;

    for p = 1 : npeaks
      b = peaks( p, 2 );
      frameRev.freq(b) = ( frameRev.amp(b-1).^2 *(b-2) + ...
                           frameRev.amp(b).^2 *(b-1) + ...
                           frameRev.amp(b+1).^2 * b ) / ...
                         ( frameRev.amp(b-1).^2 + frameRev.amp(b).^2 + ...
		              frameRev.amp(b+1).^2 ) * FS / NS;
    end;

  end;

PIs = pi*(0:SPECTRUM_SIZE-1);

%  Revise 'frameRev.phase':

  for p = 1 : npeaks
    first_b = peaks( p, 1 );
    b = peaks( p, 2 );
    last_b = peaks( p, 3 );

    if ( method == 2 ) | ( method == 0 )

%  Use the pi-rule:

      dphi = 2 * pi * frameRev.freq(b) * ...
                abs( frame.first - prevFrame.first ) / FS + ...
                  prevFrame.phase(b) - (b-first_b)*pi;   
      frameRev.phase( first_b : last_b ) = dphi + PIs(1:last_b-first_b+1);

    elseif method == 1

%  Use phase shifts from 'frame.phase':

      dphi = 2 * pi * frameRev.freq(b) * ...
                abs( frame.first - prevFrame.first ) / FS + ...
                  prevFrame.phase(b) - frame.phase(b); 
      frameRev.phase( first_b : last_b ) = ... 
                          frame.phase( first_b : last_b ) + dphi;

    else
      error( ' Impossible method ( frame_2_burst )' );
    end;

  end;

end;

frameRev.phase = frameRev.phase - 2.0*pi*fix((frameRev.phase + ...
				   sign(frameRev.phase) * pi )/(2.0*pi) );

% Create 'burst' from 'frameRev' ( .amp and .phase ):

  imag = sqrt( -1 );

  fc = imag * ones( NS, 1 );
  fc( 1 ) = frameRev.amp(1);
  fc( 2 : SPECTRUM_SIZE-1 ) = frameRev.amp( 2 : SPECTRUM_SIZE-1 ) .* ...
               exp( imag * frameRev.phase( 2 : SPECTRUM_SIZE-1 ) );
  fc( SPECTRUM_SIZE ) = frameRev.amp( SPECTRUM_SIZE );
  fc( SPECTRUM_SIZE+1 : NS ) = conj( fc( SPECTRUM_SIZE-1 : -1 : 2 ) );

  soundframe = real( ifft( fc ) );

  burst.first = frame.first;
  burst.buffer = soundframe( WINDOW_OFFSET : WINDOW_OFFSET + NW - 1 );



                    
