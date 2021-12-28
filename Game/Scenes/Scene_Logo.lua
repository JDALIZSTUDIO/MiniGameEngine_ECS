return {
  new = function(_pName)
    local Scene = require('Core/Libraries/Scenes/Scene_Default').new(_pName)

    local finished = false
    local Logo     = nil

    local fNext = function()
      local scene_manager = Locator:Get_Service("sceneManager")
      scene_manager:Next()
    end

    function Scene:Load()
      Logo = require('Game/Objects/obj_Logo').new()
      Logo:Load()
      
      if (isDebug) then print("Scenes,  loaded:      "..Scene.name) end
    end

    function Scene:Unload()
      if (isDebug) then print("Scenes,  unLoaded:    "..Scene.name) end
    end

    function Scene:Update(dt)
      Logo:Update(dt)
      
      if(finished == false and Logo.expired) then
        finished = true
        local transition = Locator:Get_Service("transition")
        transition:Start(fNext)
      end
    end

    function Scene:Draw()
      Logo:Draw()
      
    end

    function Scene:Draw_GUI()
      
    end

    return Scene
  end
}