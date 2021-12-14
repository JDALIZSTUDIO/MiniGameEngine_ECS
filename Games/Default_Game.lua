return {
    new = function()
        local game = require('Games/CoreGame').new("Default_Game")

        function game:Load_Scenes()
            Scene_Manager:Add("Scene_Logo", 'Scenes/Scene_Logo')
            Scene_Manager:Add("Scene_Menu", 'Scenes/Scene_Menu')
        end

        return game
    end
  }