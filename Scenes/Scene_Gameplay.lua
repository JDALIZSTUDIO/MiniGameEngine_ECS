local Scene = require('Scenes/Scene_Parent')
  
  ------------------
  -- Declarations --
  ------------------
  local ECS      = nil
  local Tilemap  = nil
  local Parallax = nil
  local state    = nil
  local blur     = nil
  local Timers   = nil

  local CountDown    = nil
  local startCounter = 3
  
  local blur_radius  = 20;

  ------------------------
  -- Initialize_Systems --
  ------------------------
  function Initialize_Systems()
    ECS        = require('Libraries/ECS/ECS_Manager') 
    ECS:Register(require('Libraries/ECS/Systems/s_Character_Controller').new())
    ECS:Register(require('Libraries/ECS/Systems/s_Steering').new(ECS.entities))
    ECS:Register(require('Libraries/ECS/Systems/s_Mover').new())
    --ECS:Register(require('Libraries/ECS/Systems/s_Child_Of').new())
    ECS:Register(require('Libraries/ECS/Systems/s_Collider').new(ECS.entities)) 
    ECS:Register(require('Libraries/ECS/Systems/s_Sprite_Renderer').new())
    --ECS:Register(require('Libraries/ECS/Systems/s_Animator').new())
  end

  -------------------------
  -- Initialize_Parallax --
  -------------------------
  function Initialize_Parallax()
    Parallax:Add("Images/SciFi/5.png",  0,  0, 0)
    Parallax:Add("Images/SciFi/4.png",  2,  1, 0)
    Parallax:Add("Images/SciFi/3.png", 20, -1, 0)
    Parallax:Add("Images/SciFi/2.png", 30, -1, 0)
    Parallax:Add("Images/SciFi/1.png", 40, -1, 0)
    Parallax:Add("Images/SciFi/0.png", 40, -1, 0)
  end

  ------------------------
  -- Initialize_Tilemap --
  ------------------------
  function Initialize_Tilemap()
    Tilemap:LoadMap('Libraries/Tilemap/Maps/PongMap')
  end

  ---------------------------
  -- Load_Tilemap_Entities --
  ---------------------------
  function Load_Tilemap_Entities()
    local obj, spr, player, enemy, ball, ballPos1, ballPos2
    for i = 1, #Tilemap.objects do
      obj = Tilemap.objects[i]
      if(obj.name == "enemy") then      
        enemy = ECS:Create()
        enemy:AddComponent(require('Libraries/ECS/Components/c_Transform').new(obj.x, obj.y, 0))
        enemy:AddComponent(require('Libraries/ECS/Components/c_Bounding_Box').new(0, 0, 8, 48))
        enemy:AddComponent(require('Libraries/ECS/Components/c_Sprite_Renderer').new('Images/Racket.png'))  
        enemy.name  = "enemy"
        
      elseif(obj.name == 'player') then
        player = ECS:Create()
        
        player:AddComponent(require('Libraries/ECS/Local/c_Pong_Controller').new())
        player:AddComponent(require('Libraries/ECS/Components/c_Transform').new(obj.x, obj.y, 0))
        player:AddComponent(require('Libraries/ECS/Components/c_Bounding_Box').new(0, 0, 8, 48))
        player:AddComponent(require('Libraries/ECS/Components/c_Sprite_Renderer').new('Images/Racket.png'))
        player.name  = "player"
        
        local ball_controller = require('Libraries/ECS/Local/c_Ball_Controller').new()
              ball_controller:SetTarget(player:GetComponent("transform"))
        
        ball = ECS:Create()
        ball:AddComponent(ball_controller)
        ball:AddComponent(require('Libraries/ECS/Components/c_Transform').new(obj.x + 8, obj.y, 0))
        ball:AddComponent(require('Libraries/ECS/Components/c_Bounding_Box').new(0, 0, 8, 8))
        ball:AddComponent(require('Libraries/ECS/Components/c_Sprite_Renderer').new('Images/Ball.png'))
        --ball:AddComponent(require('Libraries/ECS/Components/c_Steering').new())
        
        ball.name  = "ball"
        
        
      elseif(obj.name == "ball1") then      
        ballPos1 = Vector2:New(obj.x, obj.y)
        
      elseif(obj.name == "ball2") then      
        ballPos2 = Vector2:New(obj.x, obj.y)
        
      end
    end 
  end

  --------------------
  -- Load_Countdown --
  --------------------
  function Load_Countdown()
    local GUI     = Scene.GUI_Controller
    local imgFont = love.graphics.newImageFont('Libraries/GUI/Sprites/spr_Kromasky.png',' abcdefghijklmnopqrstuvwxyz0123456789!?:;,è./+%ç@à#')
    CountDown     = GUI:Add(GUI:SpriteFont(Round(Resolution.window.width/2) - 16, Round(Resolution.window.height/2), tostring(startCounter), imgFont, 3))
    CountDown.sX  = 8
    CountDown.sY  = 8
    
    Timers:Add("start", 1)
    Timers:Start("start")
    
  end


  ---------------------
  -- UpdateCountDown --
  ---------------------
  function Scene:UpdateCountDown()
    local scale = 8
    if(Timers:Finished("start")) then
      startCounter = startCounter - 1
      if(startCounter < 0) then
        CountDown.alpha = Lerp(CountDown.alpha, 0, 0.2)
        if(CountDown.alpha <= 0) then
          State:Set("START")
        end
      
      else
        CountDown:SetLabel(tostring(startCounter))
        CountDown.sX  = scale
        CountDown.sY  = scale
        Timers:Start("start")
      end
    else
      CountDown.sX = Lerp(CountDown.sX, 3, 0.2)
      CountDown.sY = Lerp(CountDown.sY, 3, 0.2)
      
    end  
  end

  ----------
  -- Load --
  ----------
  function Scene:Load()
    Timers   = require('Libraries/Timers').new()
    State    = require('Libraries/StateMachine').new({"NONE", "START", "GAMEPLAY", "END"})
    Parallax = require('Libraries/Parallax').new()
    Tilemap  = require('Libraries/Tilemap/Tilemap').new()
    
    Initialize_Parallax()
    Initialize_Tilemap()
    Initialize_Systems() 
    Load_Countdown()
    Load_Tilemap_Entities()
    
    local blurImage = love.graphics.newImage("Images/Shader_Textures/spr_Blur_Noise.png")
    local layer     = Parallax.layers[1]
    blur = require('Libraries/Shader').new("Shaders/shd.blur.fs")
    blur:SetUniform("noiseTexture",            blurImage)
    blur:SetUniform("noiseTextureDimensions", {blurImage:getWidth(), blurImage:getHeight()})
    blur:SetUniform("surfaceDimensions",      {layer.width, layer.height})
    blur:SetUniform("radius",                 blur_radius)
    
    State:Set("NONE")
    
    if (debug) then print("Scenes,  loaded:      "..Scene.name) end
  end

  function Scene:Unload()
    if (debug) then print("Scenes,  unLoaded:    "..Scene.name) end
  end

  ------------
  -- Update --
  ------------
  function Scene:Update(dt)
    if(debug) then
      if(love.keyboard.isDown("left"))  then blur_radius = blur_radius - 0.1 end
      if(love.keyboard.isDown("right")) then blur_radius = blur_radius + 0.1 end
      if(blur_radius < 0) then blur_radius = 0 end
    end
    
    blur:SetUniform("radius", blur_radius)
    
    ECS:Update(dt)
    Parallax:Update(dt)
    Timers:Update(dt)
    
    if(State:Compare("NONE")) then
      self:UpdateCountDown()   
    end
    
  end

  ----------
  -- Draw --
  ----------
  function Scene:Draw()
    blur:Set()
      Parallax:Draw()
    blur:UnSet()
    
    Tilemap:DrawBack()
    Tilemap:DrawFront()
      ECS:Draw()
    if(debug) then love.graphics.print(tostring(Round(blur_radius)), 10, 10) end
  end

  -------------
  -- DrawGUI --
  -------------
  function Scene:DrawGUI()
    if(self.GUI_Controller ~= nil) then
      self.GUI_Controller:Draw()
      
    end    
    
    
  end
  
return Scene