local factory  = require('Core/Libraries/ECS/Components/Controllers/c_Character_Controller')

return {
  new = function(_pECS)
    local component = factory.new(_pECS)
          
    local gameObject
    local lstTanks   = {}
    local maxTanks   = 4
    local state      = nil
    local timers     = nil
    local tName      = "spawn"
    local tDuration  = 4

    local an         = "animator"
    local tr         = "transform"

    local insert     = table.insert
    local remove     = table.remove

    -------------
    -- Animate --
    -------------
    function component:Animate()
      local animator = gameObject:Get_Component(an)
      local currentState = state:Get()

      if(currentState == "WAIT") then
        
      elseif(state:Compare("OPENING")) then
        if(animator:Is_Finished("opening")) then          
          self:Spawn_Tank()
          timers:Start(tName)
          state:Set("OPEN")
        else
          animator:Play("opening")
        end
      elseif(state:Compare("CLOSING")) then
        if(animator:Is_Finished("closing")) then
          timers:Start(tName)
          state:Set("CLOSED")
        else
          animator:Play("closing")
        end
      elseif(state:Compare("OPEN")) then        
        animator:Play("open")

      elseif(state:Compare("CLOSED")) then        
        animator:Play("closed")
      end
    end

    --------------
    -- Clean_Up --
    --------------
    function component:Clean_Up()
      local tank
      for i = #lstTanks, 1, -1 do
        tank = lstTanks[i]
        if(tank == nil) then remove(lstTanks, i) end
      end
    end

    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()
      gameObject = self.gameObject 

      state = require('Core/Libraries/State_Machine').new({"WAITOPEN", "WAITCLOSE", "OPENING", "CLOSING", "OPEN", "CLOSED"})
      timers = require('Core/Libraries/Timers').new()

      timers:Add(tName, tDuration)
      timers:Start(tName)
      state:Set("CLOSED")
    end
    
    -------------------
    -- Process_Input --
    -------------------
    function component:Process_Input()  
      
    end

    ----------------
    -- Spawn_Tank --
    ----------------
    function component:Spawn_Tank()
      local transform = gameObject:Get_Component(tr)
      local tank = gameObject.ECS:Create()
            tank.name = "enemyTank"
            tank:Add_Component(require('TESTS/ECS/Controllers/c_Enemy_Tank_Controller_TEST').new())
      local tTrans = tank:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(transform.position.x, transform.position.y, 0))
            tank:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 24, 24))
            --tank:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new())
      local anim = tank:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
            anim:Add("idle", "Game/Images/Enemies/tank_body_blue.png", 96, 96, 0, 0, 1, 1, 2, 1)
            anim:Add("move", "Game/Images/Enemies/tank_body_blue.png", 96, 96, 0, 0, 1, 2, 2, 2)

      local canon = gameObject.ECS:Create()
            canon.name = "turret"
      local cTrans = canon:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(transform.position.x, transform.position.y, 0))                    
            canon:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
            canon:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Game/Images/Player/Tank_canon.png"))
            
            tTrans:Add_Child(cTrans)            
            anim:Set_Alpha(0)

      insert(lstTanks, tank)
      print("spawning a tank")
    end

    ------------------
    -- Update_Logic --
    ------------------
    function component:Update_Logic(dt)
      local animator     = gameObject:Get_Component(an)

      if(state:Compare("WAIT")) then
        if(timers:Finished(tName)) then
          state:Set("OPENING")
        end
      elseif(state:Compare("OPENING")) then

      elseif(state:Compare("CLOSING")) then

      elseif(state:Compare("OPEN")) then
        if(timers:Finished(tName)) then
          state:Set("CLOSING")
        end
      elseif(state:Compare("CLOSED")) then
        self:Clean_Up()
        if(#lstTanks < maxTanks) then
          if(animator.Get_Name() == "closed") then
            if(timers:Finished(tName)) then
              state:Set("OPENING")
            end
          end
        end
      end
      timers:Update(dt)
    end
    
    -----------------------
    -- OnEntityCollision --
    -----------------------
    function component:OnEntityCollision(_pTable)
      
    end    
    
    return component
  end
}