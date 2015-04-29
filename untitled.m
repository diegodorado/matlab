function untitled

  zeta = .5;                           % Damping Ratio
  wn = 2;                              % Natural Frequency
  sys = tf(wn^2,[1,2*zeta*wn,wn^2]); 

  f = figure;
  ax = axes('Parent',f,'position',[0.13 0.39  0.77 0.54]);

  plot_all
  
  b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],...
                'value',zeta, 'min',0, 'max',1);

  set(b,'Callback',@sliderCallback); 

  function sliderCallback(eventSource, ~)
    obj = get(eventSource)
    zeta = obj.Value;
    sys = tf(wn^2,[1,2*zeta*wn,wn^2]); 
    plot_all;
  end

  function plot_all
    h = stepplot(ax,sys);
    setoptions(h,'XLim',[0,10],'YLim',[0,2]);
  end

end