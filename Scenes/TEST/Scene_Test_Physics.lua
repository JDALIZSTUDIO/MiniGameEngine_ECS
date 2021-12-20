return {
    new = function(_pName)
        local Scene = require('Libraries/Scenes/Scene_Parent').new(_pName)
        
        local ECS
        local Tilemap

        ----------
        -- Load --
        ----------
        function Scene:Load()
            ECS     = require('Libraries/ECS/ECS_Manager').new()
            Tilemap = require('Libraries/Tilemap/Tilemap').new()

            Tilemap:Load('Libraries/Tilemap/Maps/TESTMAP4')

            ECS:Register(require('Libraries/ECS/Systems/Controllers/s_Character_Controller').new())
            ECS:Register(require('Libraries/ECS/Systems/Collisions/s_Rigid_Body').new())    
            ECS:Register(require('Libraries/ECS/Systems/Collisions/s_Box_Collider').new())
            --ECS:Register(require('Libraries/ECS/Systems/Collisions/s_Entity_Collider').new())
            local tm = ECS:Register(require('Libraries/ECS/Systems/Collisions/s_Tilemap_Collider').new())
                  tm:Set_Tilemap(Tilemap)

            ECS:Register(require('Libraries/ECS/Systems/Movement/s_Simple_Mover').new())        
            ECS:Register(require('Libraries/ECS/Systems/Rendering/s_Box_Renderer').new())

            local player = ECS:Create()
                  player.name = "player"
                  player:AddComponent(require('TESTS/c_Tank_Controller_TEST').new())
                  local t =player:AddComponent(require('Libraries/ECS/Components/Movement/c_Transform').new(128, 48, 0))
                  player:AddComponent(require('Libraries/ECS/Components/Collisions/c_Box_Collider').new(0, 0, 16, 16))
                  player:AddComponent(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new())
                  player:AddComponent(require('Libraries/ECS/Components/Rendering/c_Box_Render').new())

            Camera:Attach(t)
        end

        ------------
        -- Update --
        ------------
        function Scene:Update(dt)
            if(love.keyboard.isDown("space")) then Camera:Shake(2, 10) end

            ECS:Update(dt)
            Tilemap:Update(dt)
        end

        ----------
        -- Draw --
        ----------
        function Scene:Draw()
            Tilemap:DrawBack()
                ECS:Draw()
            Tilemap:DrawFront()
        end

        return Scene
    end
}