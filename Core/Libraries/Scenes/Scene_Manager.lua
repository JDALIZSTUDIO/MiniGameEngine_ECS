return {
  new = function()
    local Controller = {
      lst_scenes     = {},
      current_scene  = nil,
    }

    local index = 0

    function Controller:Add(_pName, _pPath)
      local obj = {}
      obj.name = _pName
      obj.path = _pPath
      table.insert(Controller.lst_scenes, obj)
    end

    function Controller:Next()
      index = index + 1
      if(index > #Controller.lst_scenes) then index = #Controller.lst_scenes end
      
      if(Controller.current_scene  ~= nil) then
        Controller.current_scene:_PreUnload()
        Controller.current_scene:_Unload()
      end
      
      local obj = Controller.lst_scenes[index]
      Controller.current_scene = require(obj.path).new(obj.name)
      Controller.current_scene:_Awake()
      Controller.current_scene:_Load()
    end

    function Controller:Set(_pName)
      for i = 1, #Controller.lst_scenes, 1 do    
        if(Controller.lst_scenes[i].name == _pName) then
          
          index = i
          
          -- Unload Previous Scene
          if(Controller.current_scene  ~= nil) then
            Controller.current_scene:_PreUnload()
            Controller.current_scene:_Unload()
          end
          
          local obj = Controller.lst_scenes[index]
          Controller.current_scene = require (obj.path)
          Controller.current_scene.name = obj.name
          Controller.current_scene:_Awake()
          Controller.current_scene:_Load()
          break
        end
      end
    end

    function Controller:Start()
      index = 1
      local obj = Controller.lst_scenes[index]
      Controller.current_scene = require(obj.path).new(obj.name)
      Controller.current_scene:_Awake()
      Controller.current_scene:_Load()
    end

    function Controller:Update(dt)
      if(Controller.current_scene ~= nil) then
        Controller.current_scene:_Update(dt)    
      end
    end

    function Controller:Draw()
      if(Controller.current_scene ~= nil) then
        Controller.current_scene:_Draw()    
      end
    end

    function Controller:Draw_GUI()
      if(Controller.current_scene ~= nil) then
        Controller.current_scene:_Draw_GUI()    
      end
    end

    return Controller
  end
}