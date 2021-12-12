local Scene = {
      active           = true,
      loaded           = false,
      name             = "Default",
      GUI_Controller   = nil,
      SoundController  = nil,
      Surface          = nil,
}
      
function Scene:Awake()
  self.GUI_Controller  = require('Libraries/GUI/GUI_Factory')
  self.SoundController = require('Controllers/SoundController')
  if (debug) then print("Scenes,  awoken:      "..Scene.name) end
end

function Scene:Unload()

end


function Scene:PreUnload()
  self.GUI_Controller:UnLoad()
  self.GUI_Controller   = nil
  self.SoundController  = nil
  if (debug) then print("Scenes,  preUnLoaded: "..Scene.name) end
end

function Scene:Load()
  
end

function Scene:Update(dt)

end

function Scene:Draw()

end

function Scene:DrawGUI()
  if(self.GUI_Controller ~= nil) then
    self.GUI_Controller:Draw()
    
  end
end

return Scene