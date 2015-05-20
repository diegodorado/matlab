
function  powerProfile = stretchFile( inFile, outFile, stretch_factor, sec1, sec2 )

% Stretch the sound on the inFile by a factor stretch_factor
% and store the result on outFile. The inFile must be in the
% wav-format.
% The parameters sec1 and sec2 are optional.
%
%   stretchFile( inFile, outFile, stretch_factor )
%     Stretch the complete file.
%   stretchFile( inFile, outFile, stretch_factor, sec1 )
%     Stretch the first sec1 seconds of the file.
%   stretchFile( inFile, outFile, stretch_factor, sec1, sec2 )
%     Stretch from sec1 to sec2 into the sound.
%
%
%     22.11.04, pm-n.
%


globals;

openInSound( 1, inFile );

if nargin == 3
  n1 = 1;
  n2 = IN_SOUNDS( 1 ).size;
elseif nargin == 4
  n1 = 1; 
  n2 = sec_2_sample( sec1 );
elseif nargin == 5
  n1 = sec_2_sample( sec1 );
  n2 = sec_2_sample( sec2 );
else
  error( ' Wrong no. of arguments ( stretchFile )' );
end;

if n2 > IN_SOUNDS( 1 ).size
  n2 = IN_SOUNDS( 1 ).size;
end;

nFrames = floor( (n2-n1-NW+1)*stretch_factor/S_HOP + 1 );

resSound = zeros( (nFrames-1)*S_HOP+NW , 1 );

powerProfile = zeros( nFrames, 1 );

frame_2_n = floor( ( 0:nFrames-1 )' * S_HOP / stretch_factor ) + n1;

for i = 1 : nFrames

  inBurst = getMonoBurst( 1, frame_2_n(i) );

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
    [ outBurst , outFrameRev ] = frame_2_burst( outFrame, 1, outFramePrev );
    
  end;

  resSound( outBurst.first : outBurst.first + NW - 1 ) = ...
    resSound( outBurst.first : outBurst.first + NW - 1 ) + ...
                      outBurst.buffer .* BURST_WINDOW;

  powerProfile(i) = sum( inFrame.amp(:) .* inFrame.amp(:) );

  inFramePrev = inFrame;
  outFramePrev = outFrameRev;

  if rem(i,2000)==0
    fprintf('*\n');
  elseif rem(i,100)==1
    fprintf('*');
  end;

end;

powerProfile(:) = sqrt( powerProfile(:)*2/NW/NS );

outSound( resSound, outFile );

