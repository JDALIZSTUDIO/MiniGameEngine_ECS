return {
    new = function()
        local Class = require('Core/Core_Game_Loop').new("Default_Game")        

        -----------------
        -- On_Load_Assets --
        -----------------
        function Class:On_Load_Assets()
            local spriteLoader = Locator:Get_Service("spriteLoader")
                  -- GUI --
                  spriteLoader:Add_Sprite("bg_intro",         "Game/Images/Logo/BG.png")
                  spriteLoader:Add_Sprite("logo_intro",       "Game/Images/Logo/Logo.png")
                  -- UI -- 
                  spriteLoader:Add_Sprite("crosshair",        "Game/Images/UI/spr_crosshair.png")
                  -- Projectiles --     
                  spriteLoader:Add_Sprite("tank_bullet",      "Game/Images/Projectiles/spr_tank_bullet.png")
                  -- Units --     
                  spriteLoader:Add_Sprite("tank_cannon",      "Game/Images/Units/spr_tank_cannon.png")
                  spriteLoader:Add_Sprite("tank_beige",       "Game/Images/Units/spr_tank_body_beige.png")
                  spriteLoader:Add_Sprite("tank_blue",        "Game/Images/Units/spr_tank_body_blue.png")
                  spriteLoader:Add_Sprite("tank_pink",        "Game/Images/Units/spr_tank_body_pink.png")
                  spriteLoader:Add_Sprite("tank_spawner",     "Game/Images/Units/spr_tank_spawner.png")
                  -- Environment -- 
                  spriteLoader:Add_Sprite("barrel",           "Game/Images/Environment/spr_barrel.png")
                  spriteLoader:Add_Sprite("block",            "Game/Images/Environment/spr_block.png")
                  spriteLoader:Add_Sprite("brickWall",        "Game/Images/Environment/spr_brickWall.png")
                  spriteLoader:Add_Sprite("crate",            "Game/Images/Environment/spr_crate.png")
 
                  spriteLoader:Add_Sprite("barrel_hurt",      "Game/Images/Environment/spr_barrel_hurt_128x128_n20.png")
                  spriteLoader:Add_Sprite("block_hurt",       "Game/Images/Environment/spr_block_hurt_128x128_n20.png")
                  spriteLoader:Add_Sprite("brickWall_hurt",   "Game/Images/Environment/spr_brickWall_hurt_128x128_n20.png")
                  spriteLoader:Add_Sprite("crate_hurt",       "Game/Images/Environment/spr_crate_hurt_128x128_n20.png")
                   
                  -- FX -- 
                  spriteLoader:Add_Sprite("barrel_death",     "Game/Images/FX/spr_barrel_death_n35.png")
                  spriteLoader:Add_Sprite("block_death",      "Game/Images/FX/spr_block_death_128x128_n34.png")
                  spriteLoader:Add_Sprite("brickWall_death",  "Game/Images/FX/spr_brickWall_death_128x128_n30.png")
                  spriteLoader:Add_Sprite("crate_death",      "Game/Images/FX/spr_crate_death_128x128_n34.png")
                  spriteLoader:Add_Sprite("explosion1",       "Game/Images/FX/spr_explosion_100x100_n59.png")
                  spriteLoader:Add_Sprite("explosion2",       "Game/Images/FX/spr_explosion_medium_100x100_n60.png")
                  spriteLoader:Add_Sprite("explosion3",       "Game/Images/FX/spr_explosion_medium2_100x100_n60.png")
                  spriteLoader:Add_Sprite("explosionBig1",    "Game/Images/FX/spr_explosion_big1_200x200_n60.png")
                  spriteLoader:Add_Sprite("impact_bullet",    "Game/Images/FX/spr_impact_bullet_48x48_n36.png")
                  spriteLoader:Add_Sprite("smoke_particle1",  "Game/Images/FX/spr_smoke_particle.png")
                  spriteLoader:Add_Sprite("spawner_death",    "Game/Images/FX/spr_spawner_death_128x128_40.png")
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

        --------------------
        -- On_Load_Scenes --
        --------------------
        function Class:On_Load_Scenes()
            local scene_manager = Locator:Get_Service("sceneManager")
            --scene_manager:Add("Scene_Logo",       'Game/Scenes/Scene_Logo')
            --scene_manager:Add("Scene_Menu",       'Game/Scenes/Scene_Menu')
            scene_manager:Add("Test_Gameplay",    'TESTS/Scenes/Scene_Test_Gameplay')
            --scene_manager:Add("Test_Lighting",    'TESTS/Scenes/Scene_Test_Lighting')
            --scene_manager:Add("Test_Tilemap",     'TESTS/Scenes/Scene_Test_Tilemap')
            --scene_manager:Add("Test_Camera_Look", 'TESTS/Scenes/Scene_Test_Camera_Look')
            --scene_manager:Add("Test_Physics",     'TESTS/Scenes/Scene_Test_Physics')
            --scene_manager:Add("Test_Fog_Of_War",  'TESTS/Scenes/Scene_Test_Fog_Of_War')
        end

        return Class
    end
  }