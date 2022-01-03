return {
    new = function(_pName)
        local Scene = Locator:Get_Service("scene_parent").new(_pName)
        
        local camera
        local ECS
        local Fog
        local Tilemap
        
        local state
        local solid = 241
        local void  = 225

        local floor = math.floor
        local fEnemies, fEnvironment, fPlayer
        local message
        local objectives_destroyed = 0
        
        
        ----------------------------------
        -- handlers.Objective_Destroyed --
        ----------------------------------
        function love.handlers.Objective_Destroyed()
            objectives_destroyed = objectives_destroyed + 1
        end

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
            fPlayer:Init_Cursor(cursor)                  
        end

        ----------------
        -- Pause_Game --
        ----------------
        function Pause_Game()
            camera.active = false
            ECS:Pause_Game()
        end

        -----------------
        -- Resume_Game --
        -----------------
        function Resume_Game()
            camera.active = true 
            ECS:Resume_Game()
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
                    fPlayer:Init_Player(player, x, y)                
                Fog:Add(player)

                local pos = player:Get_Component("transform").position
                camera:Look_At(
                    pos.x,
                    pos.y
                )

                elseif(obj.name == "spawner") then
                    local spawner = ECS:Create()
                          spawner.name = obj.name
                    fEnemies:Init_Spawner(spawner, x, y)                          

                elseif(obj.name == "block") then
                    local block = ECS:Create()
                          block.name = obj.name
                    fEnvironment:Init_Block(block, x, y)
                          
                elseif(obj.name == "brickWall") then
                    local wall = ECS:Create()
                          wall.name = obj.name
                    fEnvironment:Init_BrickWall(wall, x, y)
                
                elseif(obj.name == "crate") then
                    local crate = ECS:Create()
                          crate.name = obj.name
                    fEnvironment:Init_Crate(crate, x, y)
                
                
                elseif(obj.name == "barrel") then
                    local barrel = ECS:Create()
                          barrel.name = obj.name
                    fEnvironment:Init_Barrel(barrel, x, y)
                         
                end
            end
            
            Load_Cursor()
        end

        ------------------
        -- Load_Systems --
        ------------------
        function Load_Systems()
            ECS:Register(require('Core/Libraries/ECS/Systems/Controllers/s_Character_Controller').new()) 
            ECS:Register(require('Core/Libraries/ECS/Systems/Collisions/s_Bounding_Box').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Collisions/s_Box_Collider').new())
            local sb = ECS:Register(require('Core/Libraries/ECS/Systems/Collisions/s_Simple_Body').new()) 
                  sb:Set_Tilemap(Tilemap)

            local rb = ECS:Register(require('Core/Libraries/ECS/Systems/Collisions/s_Rigid_Body').new()) 
                  rb:Set_Tilemap(Tilemap)
            
            ECS:Register(require('Core/Libraries/ECS/Systems/Movement/s_Transform').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Effectors/s_Health').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Rendering/s_Trail_Renderer').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Rendering/s_Animation_Renderer').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Rendering/s_Sprite_Renderer').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Rendering/s_Sprite_Renderer_GUI').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Rendering/s_Box_Renderer').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Effectors/s_Radar').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/FX/s_Particle_System').new())
            --ECS:Register(require('Core/Libraries/ECS/Systems/FX/s_Love_Particle_System').new())
        end

        ----------
        -- Load --
        ----------
        function Scene:Load()
            camera       = Locator:Get_Service("camera")
            fEnemies     = require('Game/ECS/Factories/f_Enemies').new()
            fEnvironment = require('Game/ECS/Factories/f_Environment').new()
            fPlayer      = require('Game/ECS/Factories/f_Player').new()
            state        = Locator:Get_Service("state_machine").new(
                {
                    "START",
                    "GAMEPLAY",
                    "VICTORY",
                    "DEFEAT",
                    "NEXT",
                    "WAIT"
                }
            )
            state:Set("GAMEPLAY")

            love.mouse.setVisible(false)

            ECS     = Locator:Get_Service("ecs").new()
            Tilemap = Locator:Get_Service("tilemap").new()
            Tilemap:Load('Game/Tilemaps/Maps/level01', "/Game/Tilemaps/Maps/")            
            
            local fW = Tilemap.map.width  * Tilemap.map.tilewidth
            local fH = Tilemap.map.height * Tilemap.map.tileheight
            Fog      = Locator:Get_Service("fog_of_war").new()            
            Fog:Load(fW, fH, {24/255, 20/255, 37/255, 1})
            
            local str = "level "..tostring(LEVEL)..", get ready!"
            message = require('Game/Objects/obj_Message_Gameplay').new(
                str
            )
            
            Load_Objects()
            Load_Systems()
            --Pause_Game()
        end

        ------------
        -- Update --
        ------------
        function Scene:Update(dt)
            if(love.keyboard.isDown("space")) then camera:Shake(2, 10) end

            local current = state:Get_Name()
            if(current == "START") then
                message:Update(dt)
                if(message.finished) then
                    Resume_Game()
                    state:Set("GAMEPLAY") 
                end
            elseif(current == "GAMEPLAY") then
            elseif(current == "VICTORY") then
            elseif(current == "DEFEAT") then
            elseif(current == "NEXT") then
            elseif(current == "WAIT") then
            end

            ECS:Update(dt)
            Fog:Update(dt)
            Tilemap:Update(dt)
            Fog:Set()
        end

        ----------
        -- Draw --
        ----------
        function Scene:Draw()
            Tilemap:DrawBack()
                ECS:Draw()
            Tilemap:DrawFront()
            Fog:Draw()
        end

        --------------
        -- Draw_GUI --
        --------------
        function Scene:Draw_GUI()
            ECS:Draw_GUI()
            message:Draw_GUI()
            love.graphics.print(
                "objectives: "..tostring(objectives_destroyed),
                20,
                20
            )
        end

        return Scene
    end
}