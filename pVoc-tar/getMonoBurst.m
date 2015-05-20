function  burst = getMonoBurst( track_no, first_sample )

%  Returns a 'Burst' from IN_SOUNDS( track_no ).
%  If more than one channel, the channels are averaged.
%
%     10.4.03, pm-n.

globals;

if IN_SOUNDS( track_no ).size == 0
  error( ' track_no is not associated with any sound file.( getBurst )' );
end;

if first_sample > IN_SOUNDS( track_no ).size
  burst.first = first_sample;
  burst.buffer = [];
end;

last_sample = first_sample + NW - 1;

if last_sample > IN_SOUNDS( track_no ).size
  last_sample = IN_SOUNDS( track_no ).size;
end;


if ( ( first_sample < IN_SOUNDS( track_no ).first ) | ...
     ( ( last_sample - IN_SOUNDS( track_no ).first + 1 ) > ...
                             length( IN_SOUNDS( track_no ).buffer ) ) )
 
%  IN_SOUNDS( track_no ).buffer does not contain the burst. 
%  Read a suitable part of the sound file before copying:

  f = first_sample - round( ( IN_SOUND_BUFFER_SIZE - NW )/2 );

  if f < 1
    f = 1;
  end;

  l = f + IN_SOUND_BUFFER_SIZE -1;
  
  if l > IN_SOUNDS( track_no ).size
    l = IN_SOUNDS( track_no ).size;
  end;

  [ IN_SOUNDS( track_no ).buffer, fs, bits ] = ...
                 wavread( IN_SOUNDS( track_no ).file, [ f, l ] );
  IN_SOUNDS( track_no ).first = f;

end;

  burst.first = first_sample;

  if IN_SOUNDS( track_no ).channels == 1
    burst.buffer = IN_SOUNDS( track_no ).buffer( first_sample - ...
                    IN_SOUNDS( track_no ).first + 1 : ...
                        last_sample - IN_SOUNDS( track_no ).first + 1);
  else
    burst.buffer = ( IN_SOUNDS( track_no ).buffer( first_sample - ...
                      IN_SOUNDS( track_no ).first + 1 : ...
                        last_sample - IN_SOUNDS( track_no ).first + 1, 1 ) ...
                 + IN_SOUNDS( track_no ).buffer( first_sample - ...
                    IN_SOUNDS( track_no ).first + 1 : ...
                     last_sample - IN_SOUNDS( track_no ).first + 1, 2 ) )*0.5;
  end;




























