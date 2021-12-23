return {
    new = function()
        local game = require('Core/Game_Loop/Core_Game_Loop').new("Default_Game")

        function game:Load_Scenes()
            --Scene_Manager:Add("Test_Lighting",    'TESTS/Scenes/Scene_Test_Lighting')
            --Scene_Manager:Add("Test_Tilemap",     'TESTS/Scenes/Scene_Test_Tilemap')
            --Scene_Manager:Add("Test_Camera_Look", 'TESTS/Scenes/Scene_Test_Camera_Look')
            --Scene_Manager:Add("Test_Physics",     'TESTS/Scenes/Scene_Test_Physics')
            Scene_Manager:Add("Test_Gameplay",    'TESTS/Scenes/Scene_Test_Gameplay')
            --Scene_Manager:Add("Test_Fog_Of_War",  'TESTS/Scenes/Scene_Test_Fog_Of_War')
            --Scene_Manager:Add("Scene_Logo",       'Game/Scenes/Scene_Logo')
            --Scene_Manager:Add("Scene_Menu",       'Game/Scenes/Scene_Menu')
        end

        return game
    end
  }