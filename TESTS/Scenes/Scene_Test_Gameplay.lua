return {
    new = function(_pName)
        local Scene = require('Core/Libraries/Scenes/Scene_Parent').new(_pName)
        
        local ECS
        local FOW
        local Tilemap
        
        local solid = 241
        local void  = 225

        local floor = math.floor
        
        ----------------------------
        -- handlers.Set_Collision --
        ----------------------------
        function love.handlers.Set_Collision(_pPosition)
            local x = floor(_pPosition.x / Tilemap.map.tilewidth)  + 1
            local y = floor(_pPosition.y / Tilemap.map.tileheight) + 1
            local collisions = Tilemap:Get_Collisions()
                  collisions.data[x][y] = solid
        end

        ------------------------------
        -- handlers.UnSet_Collision --
        ------------------------------
        function love.handlers.UnSet_Collision(_pPosition)
            local x = floor(_pPosition.x / Tilemap.map.tilewidth)
            local y = floor(_pPosition.y / Tilemap.map.tileheight)
            local collisions = Tilemap:Get_Collisions()
                  collisions.data[x][y] = void
        end

        -----------------
        -- Load_Cursor --
        -----------------
        function Load_Cursor()
            local cursor = ECS:Create()
                  cursor:Add_Component(require('Game/ECS/Controllers/c_Cursor_Controller').new())
                  cursor:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(0, 0, 0))
                  cursor:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_GUI_Renderer').new("Game/Images/Misc/cursor_gameplay.png"))
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
                        player:Add_Component(require('Game/ECS/Controllers/c_Tank_Body_Controller').new())
                    local pTrans = player:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                        player:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 24, 24))
                        player:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new())
                        player:Add_Component(require('Core/Libraries/ECS/Components/Lighting/c_Fog_Remover').new())
                    local anim = player:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                          anim:Add("idle", "Game/Images/Player/tank_body_sand.png", 96, 96, 0, 0, 1, 1, 2, 1)
                          anim:Add("move", "Game/Images/Player/tank_body_sand.png", 96, 96, 0, 0, 1, 2, 2, 2)
                    Camera:Attach(pTrans)

                    --player:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Box_Renderer').new())

                    local canon = ECS:Create()
                          canon.name = "turret"
                          canon:Add_Component(require('Game/ECS/Controllers/c_Tank_Canon_Controller').new())
                    local cTrans = canon:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))                    
                          canon:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
                          canon:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Game/Images/Player/Tank_canon.png"))

                    pTrans:Add_Child(cTrans)
                
                FOW:Add(player)

                elseif(obj.name == "spawner") then
                    local spawner = ECS:Create()
                          spawner.name = obj.name
                          spawner:Add_Component(require('Game/ECS/Controllers/c_Spawner_Controller').new())
                          spawner:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          spawner:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                          spawner:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Simple_Body').new())

                    local anim = spawner:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                          anim:Add("closed",  "Game/Images/Enemies/spawner_atlas.png", 32, 32, 0, 0, 1, 1, 1, 1, 0,  false)
                          anim:Add("open",    "Game/Images/Enemies/spawner_atlas.png", 32, 32, 0, 0, 2, 1, 2, 1, 0,  false)
                          anim:Add("opening", "Game/Images/Enemies/spawner_atlas.png", 32, 32, 0, 0, 1, 2, 3, 2, 15, false)
                          anim:Add("closing", "Game/Images/Enemies/spawner_atlas.png", 32, 32, 0, 0, 1, 3, 3, 3, 15, false)                   

                elseif(obj.name == "block") then
                    local block = ECS:Create()
                          block.name = obj.name
                          block:Add_Component(require('Game/ECS/Controllers/c_Solid_Controller').new())
                          block:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          block:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
                          block:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          block:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Game/Images/Environment/block.png"))
                          
                elseif(obj.name == "brickWall") then
                    local wall = ECS:Create()
                          wall.name = obj.name
                          wall:Add_Component(require('Game/ECS/Controllers/c_Solid_Controller').new())
                          wall:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          wall:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
                          wall:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          wall:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Game/Images/Environment/brickWall.png"))
                
                elseif(obj.name == "crate") then
                    local crate = ECS:Create()
                          crate.name = obj.name
                          crate:Add_Component(require('Game/ECS/Controllers/c_Solid_Controller').new())
                          crate:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          crate:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
                          crate:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          crate:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Game/Images/Environment/crate.png"))          
                
                
                elseif(obj.name == "barrel") then
                    local barrel = ECS:Create()
                          barrel.name = obj.name
                          barrel:Add_Component(require('Game/ECS/Controllers/c_Solid_Controller').new())
                          barrel:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          barrel:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
                          barrel:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          barrel:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Game/Images/Environment/barrel.png"))

                elseif(obj.name == "bush") then
                    local bush = ECS:Create()
                          bush.name = obj.name
                          bush:Add_Component(require('Game/ECS/Controllers/c_Solid_Controller').new())
                          bush:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
                          bush:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                          bush:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
                          bush:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Images/Tank_Game/bush.png"))
                          
                end
            end
        end

        ------------------
        -- Load_Systems --
        ------------------
        function Load_Systems()
            ECS:Register(require('Core/Libraries/ECS/Systems/Controllers/s_Character_Controller').new()) 
            ECS:Register(require('Core/Libraries/ECS/Systems/Collisions/s_Bounding_Box').new())
            local sb = ECS:Register(require('Core/Libraries/ECS/Systems/Collisions/s_Simple_Body').new()) 
                  sb:Set_Tilemap(Tilemap)

            local rb = ECS:Register(require('Core/Libraries/ECS/Systems/Collisions/s_Rigid_Body').new()) 
                  rb:Set_Tilemap(Tilemap)
            
            ECS:Register(require('Core/Libraries/ECS/Systems/Movement/s_Transform').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Rendering/s_Trail_Renderer').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Rendering/s_Animation_Renderer').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Rendering/s_Sprite_Renderer').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Rendering/s_Sprite_GUI_Renderer').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Rendering/s_Box_Renderer').new())
        end

        ----------
        -- Load --
        ----------
        function Scene:Load()
            love.mouse.setVisible(false)

            ECS     = require('Core/Libraries/ECS/ECS_Manager').new()
            Tilemap = require('Core/Libraries/Tilemap/Tilemap').new()

            Tilemap:Load('Game/Tilemaps/Maps/level01', "/Game/Tilemaps/Maps/")            
            
            FOW  = require('Core/Libraries/Lighting/Fog_Of_War').new()
            
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