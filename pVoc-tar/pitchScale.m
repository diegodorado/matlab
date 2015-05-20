function  ampOut = pitchScale( ampIn, scale )

% Multiplies the frequencies by the factor 'scale'.
% 
%   8.4.3, pm-n.

globals;

xIn  = [0:SPECTRUM_SIZE]';
xIn(2:SPECTRUM_SIZE) = xIn(2:SPECTRUM_SIZE)*scale;
xIn(SPECTRUM_SIZE+1) = max(SPECTRUM_SIZE,SPECTRUM_SIZE*scale);

ampLocal = zeros(SPECTRUM_SIZE+1,1);
ampLocal(1:SPECTRUM_SIZE) = ampIn(1:SPECTRUM_SIZE);

xOut = [0:(SPECTRUM_SIZE-1)]';

ampOut = interp1( xIn, ampLocal, xOut, 'linear' );


