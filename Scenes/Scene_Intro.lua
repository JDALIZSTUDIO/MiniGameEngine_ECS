local Scene = require('Scenes/Scene_Parent')

local finished = false
local Logo     = nil

local fNext = function()
  SceneController:Next()
end

function Scene:Load()
  Logo = require('Objects/obj_Logo').new()
  Logo:Load()
  
  if (debug) then print("Scenes,  loaded:      "..Scene.name) end
end

function Scene:Unload()
  if (debug) then print("Scenes,  unLoaded:    "..Scene.name) end
end

function Scene:Update(dt)
  Logo:Update(dt)
  
  if(finished == false and Logo.expired) then
    finished = true
    TransitionController:Start(fNext)
  end
end

function Scene:Draw()
  Logo:Draw()
  
end

function Scene:DrawGUI()
  
end

return Scene