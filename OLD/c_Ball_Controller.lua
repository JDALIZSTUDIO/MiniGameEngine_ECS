local CController = require('Libraries/ECS/Components/c_Character_Controller')

return {
  new = function(_pECS)
    local component = CController.new(_pECS)
          local state  = nil
          local speed  = 180
          local scale  = 8
          local rSpeed = 8
          
          local target = nil
          local trail  = {}
          local maxT   = 50
          
          ------------
          -- Launch --
          ------------
          local function Launch(_pTransform)
            local angle
            local midH     = Aspect.screen.height * (0.5 / Aspect.scale)
            local rnd      = math.random()
            
            local rndAngle = math.random(-15, 15)
            
            if(_pTransform.position.y <= midH) then
              if(math.random() >= 0.5) then
                angle = 45 + rndAngle
              
              else
                angle = 135 + rndAngle
                
              end              
            else
              if(math.random() >= 0.5) then
                angle = 225 + rndAngle
              
              else
                angle = 315 + rndAngle
                
              end              
            end
            
            local rad = math.rad(angle) % (math.pi * 2)
            local vX  = math.cos(rad) * speed
            local vY  = math.sin(rad) * speed
            
            _pTransform.velocity.x = vX
            _pTransform.velocity.y = vY            
          end          
          
          ----------
          -- Load --
          ----------
          function component:Load()
            state = require('Libraries/State_Machine').new({"START", "GAMEPLAY", "END"})
            
            local transform = self.gameObject:Get_Component("transform")
                  transform.scale:Set(scale, scale)
                  
            state:Set("START")
            
          end
          
          -----------------------
          -- OnEntityCollision --
          -----------------------
          function component:OnEntityCollision(_pTable)
            local length = #_pTable
            if(length == 0) then return end
            
            local bBox      = self.gameObject:Get_Component("boundingBox")
            local transform = self.gameObject:Get_Component("transform")            
            local objBox
            
            local obj
            for i = 1, length do
              obj    = _pTable[i]
              objBox = obj:Get_Component("transform")
              
              if(obj.name == "goal_player") then
                love.event.push("game_end", "player")
                self.gameObject.expired = true
              end
              
              if(obj.name == "goal_enemy") then
                love.event.push("game_end", "enemy")
                self.gameObject.expired = true
              end
            end            
          end
          
          ---------------------
          -- OnTileCollision --
          ---------------------
          function component:OnTileCollision(_pTileID)
            local transform = self.gameObject:Get_Component("transform")
                  transform.velocity.y = -transform.velocityPre.y
            
          end
          
          ---------------
          -- SetTarget --
          ---------------
          function component:SetTarget(_pTransform)
            target = _pTransform
            
          end
          
          ------------
          -- Update --
          ------------
          function component:Update(dt)
            local transform = self.gameObject:Get_Component("transform")
            if(state:Compare("START")) then
              transform.scale.x = Lerp(transform.scale.x, 1, 0.1)
              transform.scale.y = Lerp(transform.scale.y, 1, 0.1)
              if(transform.scale.x < 1.01 and
                 transform.scale.y < 1.01) then
                 
                 transform.scale.x = 1
                 transform.scale.y = 1
                 
                 local emitter = self.gameObject:Get_Component("trailEmitter")
                       emitter:Start()
                       
                 Launch(transform)                 
                 state:Set("GAMEPLAY")                 
              end
              
            elseif(state:Compare("GAMEPLAY")) then              
              if(transform.velocity.x > 0) then
                transform.rotation = transform.rotation + rSpeed
                
              elseif(transform.velocity.x < 0) then  
                transform.rotation = transform.rotation - rSpeed
                
              end
            end
          end
          
          ----------
          -- Draw --
          ----------
          function component:Draw()
            
          end
  
    return component
  end
}