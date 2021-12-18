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

            ECS:Register(require('Libraries/ECS/Systems/Rendering/s_Box_Renderer').new())
            ECS:Register(require('Libraries/ECS/Systems/Collisions/s_Box_Collider').new())
            ECS:Register(require('Libraries/ECS/Systems/Rendering/s_Box_Renderer').new())

            Tilemap:Load('Libraries/Tilemap/Maps/TESTMAP3')

            local player = ECS:Create()
                  player.name = "player"
                  local t =player:AddComponent(require('Libraries/ECS/Components/Movement/c_Transform').new(160, 90, 0))
                  player:AddComponent(require('Libraries/ECS/Components/Collisions/c_Box_Collider').new(0, 0, 16, 16))
                  player:AddComponent(require('Libraries/ECS/Components/Rendering/c_Box_Render').new())

            Camera:Attach(t)
        end

        ------------
        -- Update --
        ------------
        function Scene:Update(dt)
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