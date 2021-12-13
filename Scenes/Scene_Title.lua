local Scene = require('Scenes/Scene_Parent')

local finished = false
local Title    = nil

local fNext = function()
  SceneController:Next()
end

function Scene:Load()
  Title = require('Objects/obj_Title').new()
  Title:Load()
  
  if (debug) then print("Scenes,  loaded:      "..Scene.name) end
end

function Scene:Unload()
  if (debug) then print("Scenes,  unLoaded:    "..Scene.name) end
end

function Scene:Update(dt)
  Logo:Update(dt)
  
  if(finished == false and Title.expired) then
    finished = true
    TransitionController:Start(fNext)
  end
end

function Scene:Draw()
  Title:Draw()
  
end

function Scene:DrawGUI()
  
end

return Scene