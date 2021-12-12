--[[
function Load_TEST_Ship()
    local shaderFactory = require('Libraries/ECS/p_Shader')
    local aberration    = shaderFactory.new("Shaders/shd_Chromatic_Aberration.fs")
          aberration:AddUniform("aberration", 2.0)
  
    local ship = ECS:Create()
          ship:AddComponent(require('Libraries/ECS/Components/c_Transform').new(100, 100, 0))
          ship:AddComponent(require('Libraries/ECS/Components/c_Bounding_Box').new(0, 0, 8, 8))
          ship:AddComponent(require('Libraries/ECS/Components/c_Sprite_Renderer').new('Images/Spaceship1.png', aberration))
          ship:AddComponent(require('Libraries/ECS/Components/c_Steering').new())
          ship:AddComponent(require('Libraries/ECS/Tests/c_Ship_Controller').new())
          ship.name  = "ship"
    
    local engine = ECS:Create()
          engine:AddComponent(require('Libraries/ECS/Components/c_Transform').new())
          engine:AddComponent(require('Libraries/ECS/Components/s_Child_Of').new(ship:GetComponent("transform"), 0, 40))
          engine:AddComponent(require('Libraries/ECS/Components/c_Sprite_Renderer').new('Images/engine.png'))
          engine.name = "engine"
end

function Load_TEST_Animated_character()
  local player = ECS:Create()
        player:AddComponent(require('Libraries/ECS/Components/c_Transform').new(10, 10, 0))
        player:AddComponent(require('Libraries/ECS/Components/c_Bounding_Box').new(0, 0, 16, 16))        
        player.name  = "player"
        
  local animator = player:AddComponent(require('Libraries/ECS/Components/c_Animator').new())
        animator:Add("idle", 'Images/Adventurer.png', 32, 32, -2, 8, 1, 1, 13, 1)
  
end

]]--
