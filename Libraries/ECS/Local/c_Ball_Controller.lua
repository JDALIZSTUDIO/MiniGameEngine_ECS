local CController = require('Libraries/ECS/Components/c_Character_Controller')

return {
  new = function(_pECS)
    local controller = CController.new(_pECS)
          local state  = nil
          local speed  = 120
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
            local midH = Resolution.screen.height * (0.5 / Resolution.scale)
            local rnd  = math.random()
            
            if(_pTransform.position.y <= midH) then
              if(math.random() >= 0.5) then
                angle = 45
              
              else
                angle = 135
                
              end
              
            else
              if(math.random() >= 0.5) then
                angle = 225
              
              else
                angle = 315
                
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
          function controller:Load(_pEntity)
            state = require('Libraries/StateMachine').new({"START", "GAMEPLAY", "END"})
            
            local transform = _pEntity:GetComponent("transform")
                  transform.scale:Set(scale, scale)
                  
            state:Set("START")
            
          end
          
          -----------------------
          -- OnEntityCollision --
          -----------------------
          function controller:OnEntityCollision(_pEntity, _pTable)
            local length = #_pTable
            if(length == 0) then return end
            
            local bBox      = _pEntity:GetComponent("boxCollider")
            local transform = _pEntity:GetComponent("transform")
            
            local objBox
            
            local obj
            for i = 1, length do
              obj    = _pTable[i]
              objBox = obj:GetComponent("transform")
              
              
              
              --[[
              transform.velocity.x = -transform.velocity.x
              
              local inverse = false
              if(obj.name == "player") then
                if(objBox.position.x < bBox.right) then
                  if(objBox.position.y < bBox.top)    then transform.velocity.y = -transform.velocity.y end
                  if(objBox.position.y > bBox.bottom) then transform.velocity.y = -transform.velocity.y end
                end
              end
              
              if(obj.name == "enemy") then
                if(objBox.position.x > bBox.left) then
                  if(objBox.position.y < bBox.top)    then transform.velocity.y = -transform.velocity.y end
                  if(objBox.position.y > bBox.bottom) then transform.velocity.y = -transform.velocity.y end
                end
              end
              ]]--
              
              
              
            end
            
          end
          
          ---------------------
          -- OnTileCollision --
          ---------------------
          function controller:OnTileCollision(_pEntity, _pTileID)
            local transform = _pEntity:GetComponent("transform")
                  transform.velocity.y = -transform.velocityPre.y
            
          end
          
          function controller:SetTarget(_pTransform)
            target = _pTransform
            
          end
          
          ------------
          -- Update --
          ------------
          function controller:Update(dt, _pEntity)
            local transform = _pEntity:GetComponent("transform")
            if(state:Compare("START")) then
              transform.scale.x = Lerp(transform.scale.x, 1, 0.1)
              transform.scale.y = Lerp(transform.scale.y, 1, 0.1)
              if(transform.scale.x < 1.01 and
                 transform.scale.y < 1.01) then
                 
                 transform.scale.x = 1
                 transform.scale.y = 1
                 Launch(transform)
                 state:Set("GAMEPLAY")
                 
              end
              
            elseif(state:Compare("GAMEPLAY")) then              
              if(transform.velocity.x > 0) then
                transform.rotation = transform.rotation + rSpeed
                
              elseif(transform.velocity.x < 0) then  
                transform.rotation = transform.rotation - rSpeed
                
              end
              
              local length = #trail
              if(length > 50) then table.remove(trail, 1) end
              table.insert(trail, {x = transform.position.x, y = transform.position.y})
            end
          end
          
          ----------
          -- Draw --
          ----------
          function controller:Draw(_pEntity)
            local length = #trail
              if(length < 1) then return end
              
              local renderer = _pEntity:GetComponent("spriteRenderer")
              local transform = _pEntity:GetComponent("transform")
              
              local alpha, pos
              for i = 1, length do
                
                alpha = i / length * renderer.alpha * 0.1
                love.graphics.setColor(1, 1, 1, alpha)
                
                pos   = trail[i]
                love.graphics.draw(renderer.sprite, 
                                   pos.x, 
                                   pos.y, 
                                   math.rad(transform.rotation), 
                                   transform.scale.x, 
                                   transform.scale.y, 
                                   renderer.halfW, 
                                   renderer.halfH,
                                   0,
                                   0)
              end
          end
  
    return controller
  end
}