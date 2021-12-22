--[[
function Load_TEST_Ship()
    local shaderFactory = require('Libraries/ECS/p_Shader')
    local aberration    = shaderFactory.new("Shaders/shd_Chromatic_Aberration.fs")
          aberration:AddUniform("aberration", 2.0)
  
    local ship = ECS:Create()
          ship:Add_Component(require('Libraries/ECS/Components/c_Transform').new(100, 100, 0))
          ship:Add_Component(require('Libraries/ECS/Components/c_Bounding_Box').new(0, 0, 8, 8))
          ship:Add_Component(require('Libraries/ECS/Components/c_Sprite_Renderer').new('Images/Spaceship1.png', aberration))
          ship:Add_Component(require('Libraries/ECS/Components/c_Steering').new())
          ship:Add_Component(require('Libraries/ECS/Tests/c_Ship_Controller').new())
          ship.name  = "ship"
    
    local engine = ECS:Create()
          engine:Add_Component(require('Libraries/ECS/Components/c_Transform').new())
          engine:Add_Component(require('Libraries/ECS/Components/s_Child_Of').new(ship:Get_Component("transform"), 0, 40))
          engine:Add_Component(require('Libraries/ECS/Components/c_Sprite_Renderer').new('Images/engine.png'))
          engine.name = "engine"
end

function Load_TEST_Animated_character()
  local player = ECS:Create()
        player:Add_Component(require('Libraries/ECS/Components/c_Transform').new(10, 10, 0))
        player:Add_Component(require('Libraries/ECS/Components/c_Bounding_Box').new(0, 0, 16, 16))        
        player.name  = "player"
        
  local animator = player:Add_Component(require('Libraries/ECS/Components/c_Animator').new())
        animator:Add("idle", 'Images/Adventurer.png', 32, 32, -2, 8, 1, 1, 13, 1)
  
end

]]--
