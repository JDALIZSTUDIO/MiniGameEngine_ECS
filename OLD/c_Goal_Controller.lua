local CController = require('Libraries/ECS/Components/c_Character_Controller')

return {
  new = function(_pECS)
    local controller = CController.new(_pECS)
          controller.finished = false
    
    --[[
    function controller:OnEntityCollision(_pEntity, _pTable)
      print("collide")
      if(self.finished) then return end
      
      local length = #_pTable
      if(length == 0) then return end
      local obj
      for i = 1, length do
        obj    = _pTable[i]
        if(obj.name == "ball") then
          love.event.push("game_end")
        end
      end
      
    end
    ]]--
    
  
    return controller
  end
}