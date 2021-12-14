local Scene = require('Scenes/Scene_Parent')
  
  ------------------
  -- Declarations --
  ------------------
  local ECS          = nil
  local Tilemap      = nil
  local Parallax     = nil
  local state        = nil
  local blur         = nil
  local Timers       = nil
  
  local cdStart      = nil  
  local maxScale     = 16
  local minScale     = 4
  local startCounter = 3  
  local blur_radius  = 20;
  
  local ballPos1, ballPos2
  local goalPlayer, goalEnemy
  
  local enemy, player
  local labelP, labelE
  local scoreP, scoreE = 0, 0

  
  --------------------
  -- event game_end --
  --------------------
  function love.handlers.game_end(_pString)
    if(_pString == "player") then
      scoreP       = scoreP + 1
      labelP.label = tostring(scoreP)
      
    elseif(_pString == "enemy") then
      scoreE       = scoreE + 1
      labelE.label = tostring(scoreE)
      
    end    
    
    local pController = player:GetComponent("characterController")
          pController:Stop()
    
    local eController = enemy:GetComponent("characterController")
          eController:Stop()
    
  end

  ------------------------
  -- Initialize_Systems --
  ------------------------
  function Initialize_Systems()
    ECS        = require('Libraries/ECS/ECS_Manager') 
    ECS:Register(require('Libraries/ECS/Systems/s_Character_Controller').new())
    ECS:Register(require('Libraries/ECS/Systems/s_Steering').new(ECS.entities))
    local s_collider = ECS:Register(require('Libraries/ECS/Systems/s_Collider').new())
          s_collider:SetEntities(ECS.entities)
          s_collider:SetTileLayer(Tilemap)    
    
    ECS:Register(require('Libraries/ECS/Systems/s_Mover').new())
    ECS:Register(require('Libraries/ECS/Systems/s_Trail_Renderer').new())
    ECS:Register(require('Libraries/ECS/Systems/s_Sprite_Renderer').new())
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
    local obj, spr, ball
    for i = 1, #Tilemap.objects do
      obj = Tilemap.objects[i]
      if(obj.name == "enemy") then      
        enemy = ECS:Create()
        enemy:AddComponent(require('Libraries/ECS/Local/c_CPU_Controller').new(ECS))
        enemy:AddComponent(require('Libraries/ECS/Components/c_Steering').new()) 
        local collider = enemy:AddComponent(require('Libraries/ECS/Components/c_Box_Collider').new(0, 0, 8, 32))
              collider.isTrigger = false
        
        enemy:AddComponent(require('Libraries/ECS/Components/c_Transform').new(obj.x, obj.y, 0))
        enemy:AddComponent(require('Libraries/ECS/Components/c_Sprite_Renderer').new('Images/Racket.png'))
        enemy:AddComponent(require('Libraries/ECS/Components/c_DropShadow').new())        
        enemy.name = "enemy"
        
      elseif(obj.name == 'player') then
        player = ECS:Create()
        
        player:AddComponent(require('Libraries/ECS/Local/c_Pong_Controller').new())
        player:AddComponent(require('Libraries/ECS/Components/c_Steering').new())
        local collider = player:AddComponent(require('Libraries/ECS/Components/c_Box_Collider').new(0, 0, 8, 32))
              collider.isTrigger = false
        
        player:AddComponent(require('Libraries/ECS/Components/c_Transform').new(obj.x, obj.y, 0))
        player:AddComponent(require('Libraries/ECS/Components/c_Sprite_Renderer').new('Images/Racket.png'))
        player:AddComponent(require('Libraries/ECS/Components/c_DropShadow').new())
        player.name  = "player"
        
      elseif(obj.name == "ball1") then      
        ballPos1 = Vector2:New(obj.x, obj.y)
        
      elseif(obj.name == "ball2") then      
        ballPos2 = Vector2:New(obj.x, obj.y)
      
    elseif(obj.name == "goal_player") then
        local goal = ECS:Create()
              goal:AddComponent(require('Libraries/ECS/Components/c_Transform').new(obj.x, obj.y + (obj.height*0.5)))
              local collider = goal:AddComponent(require('Libraries/ECS/Components/c_Box_Collider').new(0, 0, obj.width, obj.height)) 
                    collider.isTrigger   = true
                    collider.isKinematic = false
                    
              goal.name = "goal_player"
        
      elseif(obj.name == "goal_enemy") then
        local goal = ECS:Create()
              goal:AddComponent(require('Libraries/ECS/Components/c_Transform').new(obj.x, obj.y + (obj.height*0.5)))
              local collider = goal:AddComponent(require('Libraries/ECS/Components/c_Box_Collider').new(0, 0, obj.width, obj.height)) 
                    collider.isTrigger = true                    
                    collider.isKinematic = false
                    
              goal.name = "goal_enemy"
        
      end
    end 
  end
  
  ---------------
  -- Load_Ball --
  ---------------
  function Load_Ball()    
    local pos
    if(math.random() > 0.5) then
      pos = ballPos1
    else 
      pos = ballPos2      
    end
    
    ball = ECS:Create()
    local bController = ball:AddComponent(require('Libraries/ECS/Local/c_Ball_Controller').new())
          
    ball:AddComponent(require('Libraries/ECS/Components/c_Transform').new(pos.x, pos.y, 0))
    local collider = ball:AddComponent(require('Libraries/ECS/Components/c_Box_Collider').new(0, 0, 8, 8))          
          collider.isTrigger = false
          
    ball:AddComponent(require('Libraries/ECS/Components/c_Entity_Reflector').new())
    ball:AddComponent(require('Libraries/ECS/Components/c_Trail_Emitter').new())
    ball:AddComponent(require('Libraries/ECS/Components/c_Sprite_Renderer').new('Images/Ball.png'))   
    ball:AddComponent(require('Libraries/ECS/Components/c_DropShadow').new()) 
    ball.name  = "ball"
    
  end
  
  --------------
  -- Load_GUI --
  --------------
  function Load_GUI()
    local GUI     = Scene.GUI_Controller    
    local xPlayer = Round(Resolution.window.width  * 0.38)
    local xEnemy  = Round(Resolution.window.width  * 0.6)
    local yBoth   = Round(Resolution.window.height * 0.2)    
    labelP        = GUI:Add(GUI:Label(xPlayer, yBoth, tostring(scoreP), 3))
    labelE        = GUI:Add(GUI:Label(xEnemy,  yBoth, tostring(scoreE), 3))
    
    labelP:SetFont("Libraries/GUI/Fonts/Vudotronic.otf", 8)
    labelE:SetFont("Libraries/GUI/Fonts/Vudotronic.otf", 8)
  end
  
  ----------
  -- Load --
  ----------
  function Scene:Load()
    cdStart  = require('Objects/obj_CDStart').new()
    cdStart:Load()
    
    Timers   = require('Libraries/Timers').new()
    State    = require('Libraries/StateMachine').new({"NONE", "START", "GAMEPLAY", "END"})
    Parallax = require('Libraries/Parallax').new()
    Tilemap  = require('Libraries/Tilemap/Tilemap').new()
    
    Initialize_Parallax()
    Initialize_Tilemap()
    Initialize_Systems() 
    Load_Tilemap_Entities()
    Load_GUI()
    
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
  
  ------------
  -- Unload --
  ------------
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
      if(cdStart.finished) then
        cdStart = nil
        Load_Ball()
        
        local pController = player:GetComponent("characterController")
              pController:Start()
        
        local eController = enemy:GetComponent("characterController")
              eController:Start()
        
        State:Set("START")
      else
        cdStart:Update(dt)        
      end
      
    elseif(State:Compare("START")) then
      
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
    if(State:Compare("NONE")) then
      cdStart:DrawGUI()
      
    end    
  end
  
return Scene