return {
  new = function(_pName)
    local Scene = require('Core/Libraries/Scenes/Scene_Default').new(_pName)
    
    local aspect, background, camera
    local floor  = math.floor

    local elements = {}
    local insert = table.insert
    local easing
    local amount   = 0
    local duration = 5
    local shader
    local scroller
    local tween

    ----------
    -- Load --
    ----------
    function Scene:Load()
      aspect = Locator:Get_Service("aspect")
      camera = Locator:Get_Service("camera")
      easing = Locator:Get_Service("easing")
      shader = Locator:Get_Service("shaders").new(
        "Core/Shaders/shd_alpha_radial.fs"
      )

      camera:Look_At(
        love.graphics.getWidth()  * 0.5, 
        love.graphics.getHeight() * 0.5
      )

      scroller = require('Game/Objects/obj_Background_Scroller').new(
        Locator:Get_Service("spriteLoader"):Get_Sprite("scrolling")
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
        'Game/Images/SpriteFonts/IMPACT1_n32.png',
        ' abcdefghijklmnopqrstuvwxyz!?[].'
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
            GAME_NAME, 
            spriteFont, 
            { 
              x = 2, 
              y = 2 
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
          easing.easeInOutQuad(amount, position.x, struct.endX - position.x, duration),
          easing.easeInOutQuad(amount, position.y, struct.endY - position.y, duration)
        )

        amount = amount + dt
        if(amount >= duration) then amount = duration end
      end

      scroller:Update(dt)
    end

    function Scene:Draw_GUI()
      local scaleX = love.graphics.getWidth()  / background.image:getWidth()
      local scaleY = love.graphics.getHeight() / background.image:getHeight()
      scroller:Draw()
      
      shader:Set()
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.draw(
        background.image, 
        0, 
        0, 
        0, 
        scaleX, 
        scaleY
      )
      shader:UnSet()
      
    end

    return Scene
  end
}