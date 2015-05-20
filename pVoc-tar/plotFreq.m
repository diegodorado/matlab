function   plotFreq(freq, firstFreq, lastFreq, scale, amp )

%  plotfreq plots freq ( and optionally amp) in the
%  interval [firstFreq, lastFreq].
%
%     31.3.03, pm-n.

globals;

binWidth = FS/(2*SPECTRUM_SIZE-2);

if nargin == 1

  firstBin = 1;
  lastBin = SPECTRUM_SIZE;

else

  firstBin = floor( firstFreq/binWidth ) + 1;
  if firstBin < 1
    firstBin = 1;
  end;

  lastBin = ceil( lastFreq/binWidth ) + 1;
  if lastBin > SPECTRUM_SIZE
    lastBin = SPECTRUM_SIZE;
  end;

end;

x = [firstBin-1:lastBin-1]*binWidth;

figure;

ax1 = axes( 'XColor', 'r', 'YColor', 'r',...
            'XAxisLocation', 'bottom',...
            'YAxisLocation', 'left',...
            'Color', 'none' );
hold on;

if nargin < 4
  plot( x, freq(firstBin:lastBin), '-rs' );
else
  if strcmp( scale, 'loglog' )
   set(ax1,'XScale', 'log');
   set(ax1,'YScale', 'log');
   loglog( x, freq(firstBin:lastBin), '-rs' );
  elseif strcmp( scale, 'semilogx' )
   set(ax1,'XScale', 'log');
   semilogx( x, freq(firstBin:lastBin), '-rs' );
  elseif strcmp( scale, 'semilogy' )
   set(ax1,'YScale', 'log');
   semilogy( x, freq(firstBin:lastBin), '-rs' );
  else
   plot( x, freq(firstBin:lastBin), '-rs' );
  end;
end;

grid on;
xlabel('Hz');
ylabel('Freq. ( Hz)' );


if nargin == 5

  hold on;

  ax2 = axes( 'Position', get( ax1, 'Position' ),...
              'XAxisLocation', 'top',...
              'YAxisLocation', 'right',...
              'Color', 'none', ...
              'XColor', 'b', 'YColor', 'b' );
  hold on;

  if strcmp( scale, 'loglog' )
   set(ax2,'XScale', 'log');
   set(ax2,'YScale', 'log');
   loglog( x, amp(firstBin:lastBin), '-bs' );
  elseif strcmp( scale, 'semilogx' )
   set(ax2,'XScale', 'log');
   semilogx( x, amp(firstBin:lastBin), '-bs' );
  elseif strcmp( scale, 'semilogy' )
   set(ax2,'YScale', 'log');
   semilogy( x, amp(firstBin:lastBin), '-bs' );
  else
   plot( x, amp(firstBin:lastBin), '-bs' );
  end;

end;

if nargin == 5
  title('Frequencies (red) and Amplitudes (blue)'); 
else
  title('Frequencies'); 
end;

hold off;
