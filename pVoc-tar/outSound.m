function  outSound( Sout, filename )

% outSound( Sout, filename )
%
% Writes the sound in 'Sout' to 'filename'.
%
%   If necessary, Sout is scale in order to stay 
%   within [-1:1].
%
%    13.3.03, pm-n.

globals;

[n, nch] = size( Sout );

if nch > 2
  error( ' Too many channels in outSound(...)' );
end;

% scale if necessary:

f = max( [max( max(Sout) ), -min( min(Sout) ) ] );
if f > 1
  Sout = Sout/f/1.001;
end;

wavwrite( Sout, FS, filename );

