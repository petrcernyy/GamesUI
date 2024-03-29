classdef asteroid < handle
  %ASTEROID Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    velocity = -2;
    posx
    posy
    shape = {'.::.',':::::::',':::::::',''':::'''};
    body
  end
  
  methods
    function spawn(obj, hAx)
      obj.body = text(hAx, obj.posx, obj.posy, obj.shape, 'HorizontalAlignment', 'center', 'Color', [1 1 1],'FontWeight', 'bold');
    end
    function move(obj, hAx)
      obj.posy = obj.posy + obj.velocity;
      delete(obj.body);
      obj.body = text(hAx, obj.posx, obj.posy, obj.shape, 'HorizontalAlignment', 'center', 'Color', [1 1 1],'FontWeight', 'bold');
    end
  end
end

