return {
    new = function()
        local game = require('Games/CoreGame').new("Default_Game")

        function game:Load_Scenes()
            --Scene_Manager:Add("Test_Lighting", 'Scenes/TEST/Scene_Test_Lighting')
            --Scene_Manager:Add("Test_Tilemap", 'Scenes/TEST/Scene_Test_Tilemap')
            --Scene_Manager:Add("Test_Camera_Look", 'Scenes/TEST/Scene_Test_Camera_Look')
            --Scene_Manager:Add("Test_Physics", 'Scenes/TEST/Scene_Test_Physics')
            Scene_Manager:Add("Test_Gameplay", 'Scenes/TEST/Scene_Test_Gameplay')
            --Scene_Manager:Add("Test_Fog_Of_War", 'Scenes/TEST/Scene_Test_Fog_Of_War')
            --Scene_Manager:Add("Scene_Logo", 'Scenes/Scene_Logo')
            --Scene_Manager:Add("Scene_Menu", 'Scenes/Scene_Menu')
        end

        return game
    end
  }