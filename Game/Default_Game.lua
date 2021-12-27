return {
    new = function()
        local Class = require('Core/Game_Loop/Core_Game_Loop').new("Default_Game")
        
        -----------------
        -- On_Load_Assets --
        -----------------
        function Class:On_Load_Assets()
            local spriteLoader = Locator:Get_Service("spriteLoader")
                  -- GUI --
                  -- UI --
                  spriteLoader:Add_Sprite("crosshair",       "Game/Images/UI/spr_crosshair.png")
                  -- Projectiles --    
                  spriteLoader:Add_Sprite("tank_bullet",     "Game/Images/Projectiles/spr_tank_bullet.png")
                  -- Units --    
                  spriteLoader:Add_Sprite("tank_cannon",     "Game/Images/Units/spr_tank_cannon.png")
                  spriteLoader:Add_Sprite("tank_beige",      "Game/Images/Units/spr_tank_body_beige.png")
                  spriteLoader:Add_Sprite("tank_blue",       "Game/Images/Units/spr_tank_body_blue.png")
                  spriteLoader:Add_Sprite("tank_pink",       "Game/Images/Units/spr_tank_body_pink.png")
                  spriteLoader:Add_Sprite("tank_spawner",    "Game/Images/Units/spr_tank_spawner.png")
                  -- Environment --
                  spriteLoader:Add_Sprite("barrel",          "Game/Images/Environment/spr_barrel.png")
                  spriteLoader:Add_Sprite("block",           "Game/Images/Environment/spr_block.png")
                  spriteLoader:Add_Sprite("brickWall",       "Game/Images/Environment/spr_brickWall.png")
                  spriteLoader:Add_Sprite("crate",           "Game/Images/Environment/spr_crate.png")
                  -- FX --
                  spriteLoader:Add_Sprite("barrel_death",    "Game/Images/FX/spr_barrel_death_128x128_n34.png")
                  spriteLoader:Add_Sprite("block_death",     "Game/Images/FX/spr_block_death_128x128_n37.png")
                  spriteLoader:Add_Sprite("brickWall_death", "Game/Images/FX/spr_brickWall_death_128x128_n41.png")
                  spriteLoader:Add_Sprite("crate_death",     "Game/Images/FX/spr_crate_death_128x128_n43.png")
                  spriteLoader:Add_Sprite("explosion1",      "Game/Images/FX/spr_explosion_100x100_n59.png")
                  spriteLoader:Add_Sprite("impact_bullet",   "Game/Images/FX/spr_impact_bullet_48x48_n36.png")
                  spriteLoader:Add_Sprite("smoke_particle1", "Game/Images/FX/spr_smoke_particle.png")
                  spriteLoader:Add_Sprite("spawner_death",   "Game/Images/FX/spr_spawner_death_128x128_40.png")
        end

        ----------------------
        -- On_Load_Services --
        ----------------------
        function Class:On_Load_Services()
        
        end
    
        -------------
        -- On_Load --
        -------------
        function Class:On_Load()            
            Input.keyboard:SetAxies(
                {
                    ["left"]  = 'q', 
                    ["right"] = 'd', 
                    ["up"]    = 'z', 
                    ["down"]  = 's'
                }
            )
            Input.keyboard:SetButtons(
                {
                    ["button1"] = "space", 
                    ["button2"] = "lctrl", 
                    ["button3"] = "lshift", 
                    ["button4"] = "return"
                }
            )
        end

        -----------------
        -- Load_Scenes --
        -----------------
        function Class:On_Load_Scenes()
            --Scene_Manager:Add("Test_Lighting",    'TESTS/Scenes/Scene_Test_Lighting')
            --Scene_Manager:Add("Test_Tilemap",     'TESTS/Scenes/Scene_Test_Tilemap')
            --Scene_Manager:Add("Test_Camera_Look", 'TESTS/Scenes/Scene_Test_Camera_Look')
            --Scene_Manager:Add("Test_Physics",     'TESTS/Scenes/Scene_Test_Physics')
            Scene_Manager:Add("Test_Gameplay",    'TESTS/Scenes/Scene_Test_Gameplay')
            --Scene_Manager:Add("Test_Fog_Of_War",  'TESTS/Scenes/Scene_Test_Fog_Of_War')
            --Scene_Manager:Add("Scene_Logo",       'Game/Scenes/Scene_Logo')
            --Scene_Manager:Add("Scene_Menu",       'Game/Scenes/Scene_Menu')
        end

        return Class
    end
  }