return {
    new = function(_pName)
        local Scene = require('Libraries/Scenes/Scene_Parent').new(_pName)
        
        local ECS
        local FOW
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
                    local pTrans = player:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                        player:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 24, 24))
                        player:Add_Component(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new())
                        player:Add_Component(require('Libraries/ECS/Components/Lighting/c_Fog_Remover').new())
                    local anim = player:Add_Component(require('Libraries/ECS/Components/Rendering/c_Animator').new())
                          anim:Add("idle", "Images/Tank_Game/tank_body_sand.png", 96, 96, 0, 0, 1, 1, 2, 1)
                          anim:Add("move", "Images/Tank_Game/tank_body_sand.png", 96, 96, 0, 0, 1, 2, 2, 2)
                    Camera:Attach(pTrans)

                    --player:Add_Component(require('Libraries/ECS/Components/Rendering/c_Box_Renderer').new())

                    local canon = ECS:Create()
                          canon.name = "turret"
                    local cTrans = canon:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))                    
                          canon:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                          canon:Add_Component(require('Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Images/Tank_Game/Tank_canon.png"))

                    pTrans:Add_Child(cTrans)
                
                FOW:Add(player)

                elseif(obj.name == "spawner") then
                    local spawner = ECS:Create()
                          spawner.name = obj.name
                          spawner:Add_Component(require('TESTS/c_Spawner_Controller_TEST').new())
                          spawner:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          spawner:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                          spawner:Add_Component(require('Libraries/ECS/Components/Collisions/c_Simple_Body').new())

                    local anim = spawner:Add_Component(require('Libraries/ECS/Components/Rendering/c_Animator').new())
                          anim:Add("closed",  "Images/Tank_Game/Spawner_Atlas.png", 16, 16, 0, 0, 1, 1, 3, 1)
                          anim:Add("opening", "Images/Tank_Game/Spawner_Atlas.png", 16, 16, 0, 0, 1, 2, 3, 2)
                          anim:Add("open",    "Images/Tank_Game/Spawner_Atlas.png", 16, 16, 0, 0, 1, 3, 3, 3)
                          anim:Add("closing", "Images/Tank_Game/Spawner_Atlas.png", 16, 16, 0, 0, 1, 4, 3, 4)                   

                elseif(obj.name == "block") then
                    local block = ECS:Create()
                          block.name = obj.name
                          block:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          block:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
                          block:Add_Component(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          block:Add_Component(require('Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Images/Tank_Game/block.png"))
                          
                elseif(obj.name == "brickWall") then
                    local wall = ECS:Create()
                          wall.name = obj.name
                          wall:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          wall:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
                          wall:Add_Component(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          wall:Add_Component(require('Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Images/Tank_Game/brickWall.png"))
                          
                elseif(obj.name == "bush") then
                    local grass = ECS:Create()
                          grass.name = obj.name
                          grass:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          grass:Add_Component(require('Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                          grass:Add_Component(require('Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          grass:Add_Component(require('Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Images/Tank_Game/grass.png"))
                          
                end
            end
        end

        ------------------
        -- Load_Systems --
        ------------------
        function Load_Systems()
            ECS:Register(require('Libraries/ECS/Systems/Controllers/s_Character_Controller').new()) 
            ECS:Register(require('Libraries/ECS/Systems/Collisions/s_Bounding_Box').new())
            local sb = ECS:Register(require('Libraries/ECS/Systems/Collisions/s_Simple_Body').new()) 
                  sb:Set_Tilemap(Tilemap)

            local rb = ECS:Register(require('Libraries/ECS/Systems/Collisions/s_Rigid_Body').new()) 
                  rb:Set_Tilemap(Tilemap)
            
            ECS:Register(require('Libraries/ECS/Systems/Movement/s_Transform').new())
            ECS:Register(require('Libraries/ECS/Systems/Rendering/s_Animation_Renderer').new())
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

            Tilemap:Load('Libraries/Tilemap/Maps/TESTMAP6')            
            
            FOW  = require('Libraries/Lighting/Fog_Of_War').new()
            
            local fW = Tilemap.map.width  * Tilemap.map.tilewidth
            local fH = Tilemap.map.height * Tilemap.map.tileheight

            FOW:Load(fW, fH, {24/255, 20/255, 37/255, 1})
            
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
            FOW:Update(dt)
            Tilemap:Update(dt)
            FOW:Set()
        end

        ----------
        -- Draw --
        ----------
        function Scene:Draw()
            Tilemap:DrawBack()
                ECS:Draw()
            Tilemap:DrawFront()
            FOW:Draw()
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