function dorado_tp4_matlab

  set(0,'defaultlinelinewidth',2);

  fprintf('\n');
  fprintf('---------------- \n');
  fprintf('CLASE 6 ? CONVOLUCION CONTINUA Y DISCRETA \n');
  fprintf('---------------- \n');
  fprintf('\n');
  fprintf('Ejercicio: Desarrollar el algoritmo de convoluci?n discreta en MatLab. \n');
  fprintf('Simular,utilizando un paso temporal de 0.01s, la siguiente convoluci?n cont?nua: \n');
  fprintf(' exp(-2t)u(t) * [u(t)-u(t-1)] \n');
  fprintf('Verificar los resultados con el comando conv de matlab.\n');
  fprintf('\n');



  f = figure(1);
  clf;
  
  t1 = -1:0.1:5;
  t2 = 0:0.1:3;
  x1 = exp(-2*t1).*ideal.escalon(t1);
  x2 = ideal.escalon(t2) - ideal.escalon(t2-1);
  
  t1_duration = t1(length(t1))-t1(1);
  t2_duration = t2(length(t2))-t2(1);
  
  ti = -10; % t2(1) - t1_duration
  ti2 = t2(1) - t1_duration - t1(1)
  tf = 10; %ti + t2_duration + t2_duration
  y_values = horzcat(x1,x2);
  y_min = min(y_values);
  y_max = max(y_values);
  y2_min = min([y_min*y_min, y_min*y_max,y_max*y_max]);
  y2_max = max([y_min*y_min, y_min*y_max,y_max*y_max]);
  
  
  subplot(3,1,1);
  plot(t1,x1,t2,x2);
  axis([ti tf y_min-1 y_max+1])
  grid;
  subplot(3,1,2);


  %// re-position the axes to make room for the slider
  set(gca, 'position', [0.1 0.25 0.85 0.7]);

  %// initialize the slider
  h = uicontrol(...
      'parent'  , f,...        
      'units'   , 'normalized',...    %// so yo don't have to f*ck with pixels
      'style'   , 'slider',...        
      'position', [0.1 -0.13 0.85 0.2],...
      'min'     , ti,...               %// Make the A between 1...
      'max'     , tf,...              %// and 10, with initial value
      'value'   , tf,...               %// as set above.
      'callback', @sliderCallback);   %// This is called when using the arrows
                                      %// and/or when clicking the slider bar


  %// THE MAGIC INGREDIENT
  %// ===========================

  hLstn = handle.listener(h,'ActionEvent',@sliderCallback); %#ok<NASGU>
  %// (variable appears unused, but not assigning it to anything means that 
  %// the listener is stored in the 'ans' variable. If "ans" is overwritten, 
  %// the listener goes out of scope and is thus destroyed, and thus, it no 
  %// longer works.

  %// ===========================


  %// The slider's callback:
  %//    1) clears the old plot
  %//    2) computes new values using the (continuously) updated slider values
  %//    3) re-draw the plot and re-set the axes settings
  function sliderCallback(~,~)
    deletePlot;
    createPlot;
  end


  p =0;
  function createPlot
    subplot(3,1,2);
    t0 = get(h,'value');
    
    p = plot(t1+ti2+t0,fliplr(x1),t2,x2);
    %corregir los limites y para la convolucion
    axis([ti tf y2_min y2_max])
    line([t0 t0], get(gca,'ylim'), 'LineStyle','--', 'LineWidth',1, 'Marker','p', 'Color','m');
    
    grid;    
  end

  function deletePlot
    delete(p);
  end


  createPlot;


  
end