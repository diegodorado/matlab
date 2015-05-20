function   plotPeaks(amp, firstFreq, lastFreq, peaks, scale)

%  Plots amp ( a column )  in the interval [firstFreq, lastFreq]. 
%  The peaks are shown by alternating the colours red and green.
%
%     31.3.03, pm-n.

globals;

binWidth = FS/(2*SPECTRUM_SIZE-2);

firstBin = floor( firstFreq/binWidth ) + 1;
if firstBin < 1
  firstBin = 1;
end;

lastBin = ceil( lastFreq/binWidth ) + 1;
if lastBin > SPECTRUM_SIZE
  lastBin = SPECTRUM_SIZE;
end;

x = (firstBin-1:lastBin-1)*binWidth;

figure;

ax1 = axes( 'XColor', 'k', 'YColor', 'k',...
            'XAxisLocation', 'bottom',...
            'YAxisLocation', 'left',...
            'Color', 'none' );
hold on

if nargin == 5

  if strcmp( scale, 'loglog' )
    set( ax1, 'XScale', 'log' );
    set( ax1, 'YScale', 'log' );
  elseif strcmp( scale, 'semilogx' )
    set( ax1, 'XScale', 'log' );
  elseif strcmp( scale, 'semilogy' )
    set( ax1, 'YScale', 'log' );
  end;

end;
    
plot( x, amp(firstBin:lastBin), '-k' );

[nPeaks, cols] = size(peaks);

col = '-g*';
for p= 1:nPeaks
  fi = peaks(p,1);
  la = peaks(p,3);
  if ( fi < lastBin ) & ( la > firstBin )
    if fi < firstBin
      fi = firstBin;
    end;
    if la > lastBin
      la = lastBin;
    end;
    plot( x(fi-firstBin+1:la-firstBin+1), amp(fi:la), col );
    if strcmp( col, '-r*' )
      col = '-g*';
    else
      col = '-r*';
    end;
  end;
end; 

grid on;
xlabel('Hz');
ylabel('Amp.');
title('Amplitudes and peaks ( alternating colours )' );

hold off;

