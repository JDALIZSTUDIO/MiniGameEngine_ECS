return {
    new = function(_pName)
        local Scene = require('Libraries/Scenes/Scene_Parent').new(_pName)
        
        local ECS
        local Tilemap
        
        -----------------
        -- Load_Cursor --
        -----------------
        function Load_Cursor()
            local cursor = ECS:Create()
                  cursor:Add_Component(require('Libraries/ECS/Local/c_Cursor_Controller').new())
                  cursor:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(0, 0, 0))
                  cursor:Add_Component(require('Libraries/ECS/Components/Rendering/c_Sprite_GUI_Renderer').new("Images/Tank_Game/Cursor_Gameplay2.png"))
        end


        ------------------
        -- Load_Objects --
        ------------------
        function Load_Objects()
            local obj
            local objects = Tilemap:Get_Objects()
            for i = 1, #objects do
                obj = objects[i]
                local x = obj.x + (obj.width*0.5)
                local y = obj.y - (obj.height*0.5)
                if(obj.name == "player") then
                    local player = ECS:Create()
                        player.name = obj.name
                        player:Add_Component(require('TESTS/c_Tank_Controller_TEST').new())
                        local t = player:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                        player:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                        player:Add_Component(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new())
                        player:Add_Component(require('Libraries/ECS/Components/Rendering/c_Box_Renderer').new())

                    Camera:Attach(t)
                elseif(obj.name == "block") then
                    local block = ECS:Create()
                          block.name = obj.name
                          block:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          block:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                          block:Add_Component(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          block:Add_Component(require('Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Images/Tank_Game/block.png"))
                          --block:Add_Component(require('Libraries/ECS/Components/Rendering/c_Box_Renderer').new())
                elseif(obj.name == "wall") then
                    local wall = ECS:Create()
                          wall.name = obj.name
                          wall:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          wall:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                          wall:Add_Component(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          wall:Add_Component(require('Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Images/Tank_Game/wall.png"))
                          --wall:Add_Component(require('Libraries/ECS/Components/Rendering/c_Box_Renderer').new())
                elseif(obj.name == "bush") then
                    local grass = ECS:Create()
                          grass.name = obj.name
                          grass:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          grass:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                          grass:Add_Component(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          grass:Add_Component(require('Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Images/Tank_Game/grass.png"))
                          --grass:Add_Component(require('Libraries/ECS/Components/Rendering/c_Box_Renderer').new())
                end
            end
        end

        ------------------
        -- Load_Systems --
        ------------------
        function Load_Systems()
            ECS:Register(require('Libraries/ECS/Systems/Controllers/s_Character_Controller').new()) 
            ECS:Register(require('Libraries/ECS/Systems/Collisions/s_Bounding_Box').new())
            local rb = ECS:Register(require('Libraries/ECS/Systems/Collisions/s_Rigid_Body').new()) 
                  rb:Set_Tilemap(Tilemap)
       
            ECS:Register(require('Libraries/ECS/Systems/Rendering/s_Sprite_Renderer').new())
            ECS:Register(require('Libraries/ECS/Systems/Rendering/s_Sprite_GUI_Renderer').new())
            ECS:Register(require('Libraries/ECS/Systems/Rendering/s_Box_Renderer').new())

        end

        ----------
        -- Load --
        ----------
        function Scene:Load()
            love.mouse.setVisible(false)

            ECS     = require('Libraries/ECS/ECS_Manager').new()
            Tilemap = require('Libraries/Tilemap/Tilemap').new()

            Tilemap:Load('Libraries/Tilemap/Maps/TESTMAP5')
            
            Load_Cursor()
            Load_Objects()
            Load_Systems()
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

        --------------
        -- Draw_GUI --
        --------------
        function Scene:Draw_GUI()
            ECS:Draw_GUI()
        end

        return Scene
    end
}