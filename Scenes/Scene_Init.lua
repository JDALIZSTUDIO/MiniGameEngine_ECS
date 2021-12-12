local Scene = require('Scenes/Scene_Parent')

function Scene:Load()
  
  local fnIntro = function()
    SceneController:Next()
  end

  TransitionController:Start(fnIntro)
  
  if (debug) then print("Scenes,  loaded:      "..Scene.name) end
end

function Scene:Unload()
  if (debug) then print("Scenes,  unLoaded:    "..Scene.name) end
end

function Scene:Update(dt)

end

function Scene:Draw()

end

function Scene:DrawGUI()
  
end

return Scene