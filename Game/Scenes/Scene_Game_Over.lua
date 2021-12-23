return {
  new = function(_pName)
      local Scene = require('Core/Libraries/Scenes/Scene_Parent').new(_pName)

      ----------------------
      -- PUBLIC FUNCTIONS --
      ----------------------

      -----------
      -- Awake --
      ----------- 
      function Scene:Awake()

      end

      ------------
      -- Unload --
      ------------
      function Scene:Unload()

      end

      ---------------
      -- PreUnload --
      ---------------
      function Scene:PreUnload()

      end

      ----------
      -- Load --
      ----------
      function Scene:Load()

      end

      ------------
      -- Update --
      ------------
      function Scene:Update(dt)

      end

      ----------
      -- Draw --
      ----------
      function Scene:Draw()

      end

      -------------
      -- Draw_GUI --
      -------------
      function Scene:Draw_GUI()
          
      end

      return Scene
  end
}