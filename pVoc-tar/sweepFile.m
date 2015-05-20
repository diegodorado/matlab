function sweepFile( inFile, outFile, time_map )

%  A sound is produced ( and stored in outFile ) by
%  sweeping over the sound in inFile according
%  to time_map.

%  22.11.04, pm-n.


globals;

openInSound( 1, inFile );

INTER_METHOD = 'linear';


% Calc. 'frame2sample' :

N = IN_SOUNDS( 1 ).size;

[Nmap, dummy] = size( time_map );
if dummy ~=2
  error('Wrong size of time_map. ( sweepFile )' );
end;

if time_map(1,1) ~= 0
  error(' Time in sOUT must start at 0. ( sweepFile )' );
end;

NFRAMES = floor((time_map(Nmap,1)*FS-NW)/S_HOP)+1;
frame2sample = ones(NFRAMES,2);
method = ones(NFRAMES,1);

% Plot 'time_map' as interpolated:

xx = [time_map(1,1):0.01:time_map(Nmap,1)];
yy = interp1(time_map(:,1),time_map(:,2),xx,INTER_METHOD);
plot(xx,yy,time_map(:,1),time_map(:,2),'ro');

title('SweepFile:  time-map');
xlabel('time ( sec. ) in sOUT');
ylabel('time ( sec. ) in sIN');
axis equal;
grid on;
drawnow;

frame2sample(1,1) = time_map(1,2)*FS+1;
frame2sample(1,2) = 1;
method(1) = 1;

if ( frame2sample(1,1) < 1 ) | ( (frame2sample(1,1)+NW-1) > N )
  error('First frame is out of range. ( sweepFile )');
end;

for f = 2 : NFRAMES

  tOUT = (f-1)*S_HOP/FS;

  tIN = interp1(time_map(:,1),time_map(:,2),tOUT,INTER_METHOD);

  frame2sample(f,1) = round( tIN*FS+1 );

  if frame2sample(f,1) == frame2sample(f-1,1) 
    frame2sample(f,2) = frame2sample(f-1,2);
  elseif frame2sample(f,1) > frame2sample(f-1,1)
    frame2sample(f,2) = 1;
  else
    frame2sample(f,2) = -1;
  end;
 
  if frame2sample(f,2) ~= frame2sample(f-1,2)
    method(f) = 2;
  else
    method(f) = 1;
  end;
   
  if ( frame2sample(f,1) < 1 ) | ( ( frame2sample(f,1)+NW-1 ) > N )
    frame2sample(f,1) = frame2sample(f-1,1);
    frame2sample(f,2) = frame2sample(f-1,2);
    method(f) = method(f-1);
  end;

end;

resSound = zeros( (NFRAMES-1)*S_HOP+NW , 1 );

for i = 1 : NFRAMES

  if frame2sample(i,2) == 1
    inBurst = getMonoBurst( 1, frame2sample(i,1) );
  else
    inBurst = getMonoBurst( 1, frame2sample(i,1)-NW+1 );
    inBurst.first = frame2sample(i,1);
    inBurst.buffer = inBurst.buffer( NW : -1 : 1 );
  end;
    
  if i == 1

    inFrame = burst_2_frame( inBurst );
    outFrameRev = inFrame;
    outFrameRev.first = 1;
    outBurst = inBurst;
    outBurst.first = 1;

  else

    inFrame = burst_2_frame( inBurst, inFramePrev );
    outFrame = inFrame;
    outFrame.first = ( i-1 )*S_HOP + 1;
    [ outBurst , outFrameRev ] = ...
           frame_2_burst( outFrame, method(i), outFramePrev );
    
  end;

  resSound( outBurst.first : outBurst.first + NW - 1 ) = ...
    resSound( outBurst.first : outBurst.first + NW - 1 ) + ...
                      outBurst.buffer .* BURST_WINDOW;

  inFramePrev = inFrame;
  outFramePrev = outFrameRev;

  if rem(i,2000)==0
    fprintf('*\n');
  elseif rem(i,100)==1
    fprintf('*');
  end;

end;

outSound( resSound, outFile );

