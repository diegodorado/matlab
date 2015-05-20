
function  frameM =morphSpec( frameL, frameU, sampleM )

%  Construct frameM from frameL and frameU so that frameM.first
%  is sampleM.

%     9.5.03, pm-n.


DTOL         = 0.08;  % m2 = 1.06 , M2 = 1.12


peaksL = findPeaks( frameL.amp );
peaksU = findPeaks( frameU.amp );

[nL, dummy] = size( peaksL );
[nU, dummy] = size( peaksU );

pL     = 1;
pU     = 1;
minD   = realmax;
min_pL = 0;
min_pU = 0;


if ( nL >= 1 ) & ( nU >= 1 )

  % Pitchscaling is attempted 

  while ( pL <= nL ) & ( pU <= nU )

    dRel = 2 * ( frameL.freq(peaksL(pL,2)) - frameU.freq(peaksU(pU,2)) ) ...
             / ( frameL.freq(peaksL(pL,2)) + frameU.freq(peaksU(pU,2)) );

    if abs( dRel ) < minD
      minD = abs( dRel );
      min_pL = pL;
      min_pU = pU;
    end;

    if minD <= DTOL
      break;
    end;

    if dRel > 0
      pU = pU+1;
    else
      pL = pL+1;
    end;

  end;

  freqL = frameL.freq( peaksL( min_pL, 2 ) );
  freqU = frameU.freq( peaksU( min_pU, 2 ) );

else

  freqL = 1;
  freqU = freqL;  % scalefactor is 1

end;

t     = (sampleM - frameL.first)/(frameU.first - frameL.first);
freqF = (1-t)*freqL + t*freqU;

frameM.amp = (1-t)*pitchScale( frameL.amp, freqF/freqL ) ...
              + t*pitchScale( frameU.amp, freqF/freqU );

frameM.first = sampleM;
frameM.freq = [];
frameM.phase = [];


