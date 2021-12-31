return {
  new = function(_pName)
    local Scene = require('Core/Libraries/Scenes/Scene_Default').new(_pName)
    
    local aspect, background, camera
    local floor  = math.floor

    local elements = {}
    local insert = table.insert
    local easing
    local amount   = 0
    local duration = 0.1
    local tween

    ----------
    -- Load --
    ----------
    function Scene:Load()
      aspect = Locator:Get_Service("aspect")
      camera = Locator:Get_Service("camera")
      easing = Locator:Get_Service("easing")
      camera:Look_At(
        love.graphics.getWidth()  * 0.5, 
        love.graphics.getHeight() * 0.5
      )
      
      ----------------
      -- background --
      ----------------
      local spriteLoader = Locator:Get_Service("spriteLoader")
      background = spriteLoader:Get_Sprite("bg_intro")

      -----------------
      -- Transitions --
      -----------------
      local fnTransPlay = function()
        local scene_manager = Locator:Get_Service("sceneManager")
        scene_manager:Next()
      end
      
      local fnTransQuit = function()
        love.event.quit(0)
      end      
      
      -------------------
      -- GUI_functions --
      -------------------
      local fnPlay = function()
        local transition = Locator:Get_Service("transition")
        transition:Start(fnTransPlay)
      end

      local fnOptions = function()
        
      end

      local fnQuit = function()
        local transition = Locator:Get_Service("transition")
        transition:Start(fnTransQuit)
      end

      ------------------
      -- GUI_elements --
      ------------------
      local spriteFont = love.graphics.newImageFont(
        'Game/Images/SpriteFonts/spr_Kromasky.png',
        ' abcdefghijklmnopqrstuvwxyz0123456789!?:;,è./+%ç@à#'
      )
      
      local endX, endY, startX, StartY
      local screenH = love.graphics.getHeight()

      -- title --
      endX   = Round(aspect.window.width/2)
      endY   = floor(aspect.window.height/4)
      startX = endX
      startY = endY + screenH
      local title = {
        element = self.GUI:Add(
          self.GUI.element.spriteFont.new(
            startX, 
            startY, 
            "my game", 
            spriteFont, 
            { 
              x = 3, 
              y = 3 
            }
          )
        ),  
        startX = startX,
        startY = startY,
        endX   = endX, 
        endY   = endY
      }  

      -- button play --
      endY   = floor(aspect.window.height/1.8)
      startY = endY + screenH
      local play = {
        element = self.GUI:Add(
          self.GUI.element.button.new(
            startX, 
            startY, 
            "Play",    
            "Core/Libraries/GUI/Sprites/ButtonStrip.png", 
            96, 
            32, 
            fnPlay
          )
        ),  
        startX = startX,
        startY = startY,
        endX   = endX, 
        endY   = endY
      }

      -- button options --
      endY      = floor(aspect.window.height/1.6)
      startY    = endY + screenH

      local options = {
        element = self.GUI:Add(
          self.GUI.element.button.new(
            startX, 
            startY, 
            "Options", 
            "Core/Libraries/GUI/Sprites/ButtonStrip.png", 
            96, 
            32, 
            fnOptions
          )
        ),  
        startX = startX,
        startY = startY,
        endX   = endX, 
        endY   = endY
      }
      
      -- button quit --
      endY   = floor(aspect.window.height/1.3)
      startY = endY + screenH

      local quit = {
        element = self.GUI:Add(
          self.GUI.element.button.new(
            startX, 
            startY, 
            "Quit",
            "Core/Libraries/GUI/Sprites/ButtonStrip.png", 
            96, 
            32, 
            fnQuit)
        ),  
        startX = startX,
        startY = startY,
        endX   = endX, 
        endY   = endY
      }
      
      insert(elements, title)
      insert(elements, play)
      insert(elements, options)
      insert(elements, quit)       

      if (isDebug) then print("Scenes,  loaded:      "..Scene.name) end
    end

    function Scene:Update(dt)
      local position
      local struct, element
      for i = 1, #elements do
        struct  = elements[i]
        element    = struct.element
        position   = element:Get_Position()
        element:Set_Position(
          easing.easeInOutCubic(amount, position.x, struct.endX - position.x, duration),
          easing.easeInOutCubic(amount, position.y, struct.endY - position.y, duration)
        )

        amount = amount + dt
        if(amount >= duration) then amount = duration end
      end
    end

    function Scene:Draw()      
      local scaleX = love.graphics.getWidth()  / background.image:getWidth()
      local scaleY = love.graphics.getHeight() / background.image:getHeight()
      
      love.graphics.setColor(1, 1, 1, 1)
          love.graphics.draw(
            background.image, 
            0, 
            0, 
            0, 
            scaleX, 
            scaleY
          )
    end

    return Scene
  end
}