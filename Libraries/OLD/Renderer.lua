local Renderer = {
      maxLayers = 5
}


function Renderer:Create()
  local renderer = {
        drawers  = {}
  }
  
  for i = 1, Renderer.maxLayers, 1 do
    renderer.drawers[i] = {}
  end
  
  function renderer:AddRenderer(_pObj, _pLayer)
    local l = _pLayer or 0
    table.insert(self:drawers[l], _pObj)
  end
  
  function renderer:Draw()
    local obj
    for layer  = 1, #self.drawers, 1 do
      for draw = 1, #self.drawers[layer], 1 do
        obj = self.drawers[layer][draw]
        if(obj ~= nil) then
          obj:Draw()
        end      
      end
    end    
  end
  
  return renderer
end


return Renderer