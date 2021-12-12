local SC           = {
      LstScenes    = {},
      CurrentScene = nil,
}

local index = 0

function SC:Add(_pName, _pPath)
  local obj = {}
  obj.name = _pName
  obj.path = _pPath
  table.insert(SC.LstScenes, obj)
end

function SC:Next()
  index = index + 1
  if(index > #SC.LstScenes) then index = #SC.LstScenes end
  
  if(SC.CurrentScene  ~= nil) then
    SC.CurrentScene:PreUnload()
    SC.CurrentScene:Unload()
  end
  
  local obj = SC.LstScenes[index]
  SC.CurrentScene = require(obj.path)
  SC.CurrentScene.name = obj.name
  SC.CurrentScene:Awake()
  SC.CurrentScene:Load()
end

function SC:Set(_pName)
  for i = 1, #SC.LstScenes, 1 do    
    if(SC.LstScenes[i].name == _pName) then
      
      index = i
      
      -- Unload Previous Scene
      if(SC.CurrentScene  ~= nil) then
        SC.CurrentScene:PreUnload()
        SC.CurrentScene:Unload()
      end
      
      local obj = SC.LstScenes[index]
      SC.CurrentScene = require (obj.path)
      SC.CurrentScene.name = obj.name
      SC.CurrentScene:Awake()
      SC.CurrentScene:Load()
      break
    end
  end
end

function SC:Start()
  index = 1
  local obj = SC.LstScenes[index]
  SC.CurrentScene = require (obj.path)
  SC.CurrentScene.name = obj.name
  SC.CurrentScene:Awake()
  SC.CurrentScene:Load()
end

function SC:Update(dt)
  if(SC.CurrentScene ~= nil) then
    SC.CurrentScene:Update(dt)    
  end
end

function SC:Draw()
  if(SC.CurrentScene ~= nil) then
    SC.CurrentScene:Draw()    
  end
end

function SC:DrawGUI()
  if(SC.CurrentScene ~= nil) then
    SC.CurrentScene:DrawGUI()    
  end
end

return SC