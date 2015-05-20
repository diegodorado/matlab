function plot_conv(t1,x1,t2,x2)

  f = figure(1);
  clf;

  max_y = abs(max(x1)*max(x2));
  h = t1(2)-t1(1);
  
  L1 = (length(t1)-1)*h;
  L2 = (length(t2)-1)*h;
  ti = t2(1);
  tf = ti + L1 + L2;

  
  N=length(x1);
  M=length(x2);
  
  t = ti:h:tf;
  y = zeros(1,length(t));
  
  for i = 1:N+M+1
   if i<=M
    for j=0:i-1
     y(i)=y(i)+x1(i-j)*x2(j+1);
    end
   elseif(i<=N)
    for j=0:M-1
     y(i)=y(i)+x1(i-j)*x2(j+1);
    end
   else    
     for j=i-N:M-1
      y(i)=y(i)+x1(i-j)*x2(j+1);
     end
   end
   
  end  
  
  
  subplot(4,1,1);
  plot(t1,x1,t2,x2);
  legend('x1', 'x2');
  fitPlot();  

  y2 = conv(x1,x2);
  
  subplot(4,1,4);
  plot(t,y,t,y2,t,abs(y-y2));
  legend('custom conv', 'matlab conv', 'diff');
  fitPlot();

  
  
  subplot(4,1,2);
  

  %// re-position the axes to make room for the slider
  set(gca, 'position', [0.1 0.25 0.85 0.7]);

  %// initialize the slider
      %'SliderStep' , [h, h*10], ...
  sliderHandler = uicontrol(...
      'parent'  , f,...        
      'units'   , 'normalized',...    %// so yo don't have to f*ck with pixels
      'style'   , 'slider',...  
      'position', [0.1 -0.13 0.85 0.2],...
      'min'     , ti-L2,...               %// Make the A between 1...
      'max'     , tf+1,...              %// and 10, with initial value
      'value'   , tf,...               %// as set above.
      'callback', @sliderCallback);   %// This is called when using the arrows
                                      %// and/or when clicking the slider bar


  %// THE MAGIC INGREDIENT
  %// ===========================

  hLstn = handle.listener(sliderHandler,'ActionEvent',@sliderCallback); %#ok<NASGU>
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
    deletePlot();
    createPlot();
  end



  p1 =0;
  p2 =0;
  function createPlot()
    t0 = ceil(get(sliderHandler,'value')/h)*h;
    subplot(4,1,2);    
    p1 = plot(t0+t1-L1-t1(1),fliplr(x1),t2,x2);
    legend('x1', 'x2');
    
    fitPlot();
    line([t0 t0], get(gca,'ylim'), 'LineStyle','--', 'LineWidth',1, 'Marker','p', 'Color','m');

    p2 = subplot(4,1,3);
    
    
    t3 = (t0-L1:h:t0);
    x1_f = fliplr(x1);
    x1_f = x1_f(t3>=ti & t3<=tf);
    x1_o = ceil((t0-L1 - ti)/h);
    x1_o = x1_o * (x1_o>0);
    
    y1 = zeros(1,length(t));
    y2 = y1;
    
    y1(1+x1_o:length(x1_f)+x1_o) = x1_f;
    
    y2(1:length(x2)) = x2;

    y = y1.*y2;
    plot(t,y);
    %fill(t,y,'g')
    fitPlot([-max_y ,max_y]);
    legend('(x1(t0-t) * x2(t))');

    
    
    
  end

  function deletePlot()
    delete(p1);    
    delete(p2);    
  end


  function fitPlot(y_l)
    
    if nargin < 1
      y_l = ylim;
    end
    
    xlim([ti-L2, tf+1]);
    
    d = (y_l(2)-y_l(1)) * 0.2;
    ylim ([y_l(1)-d ,y_l(2)+d]);
    grid;
  end

  createPlot();


  
end  