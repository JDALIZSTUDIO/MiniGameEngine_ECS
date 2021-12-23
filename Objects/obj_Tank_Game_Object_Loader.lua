return {
    new = function()
        local Loader = {}

        -------------------
        -- Parse_Objects --
        -------------------
        function Loader:Parse_Objects(_pECS, _pObjects)
            local obj
            for i = 1, #_pObjects do
                obj = _pObjects[i]
                local x = obj.x + (obj.width*0.5)
                local y = obj.y - (obj.height*0.5)
                if(obj.name == "player") then
                    local player = _pECS:Create()
                        player.name = obj.name
                        player:Add_Component(require('TESTS/c_Tank_Controller_TEST').new())
                        local t = player:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                        player:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                        player:Add_Component(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new())
                        player:Add_Component(require('Libraries/ECS/Components/Rendering/c_Box_Renderer').new())
                    Camera:Attach(t)

                elseif(obj.name == "block") then
                    local block = _pECS:Create()
                          block.name = obj.name
                          block:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          block:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                          block:Add_Component(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          block:Add_Component(require('Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Images/Tank_Game/block.png"))
                          
                elseif(obj.name == "wall") then
                    local wall = _pECS:Create()
                          wall.name = obj.name
                          wall:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          wall:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                          wall:Add_Component(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          wall:Add_Component(require('Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Images/Tank_Game/wall.png"))
                          
                elseif(obj.name == "bush") then
                    local grass = _pECS:Create()
                          grass.name = obj.name
                          grass:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          grass:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                          grass:Add_Component(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          grass:Add_Component(require('Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Images/Tank_Game/grass.png"))
                          
                end
            end
        end

        return Loader
    end
}